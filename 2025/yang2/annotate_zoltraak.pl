#!/usr/bin/perl -w

use strict;
use constant LABEL_PREFIX => "L";

my @lines = <>;

# Convert character code to string, escaping special and unprintable characters.
sub to_char($)
{
   my ($c) = @_;

   if( $c == ord("\n") ) { return "\\n"; }
   if( $c == ord("\r") ) { return "\\r"; }
   if( $c == ord("\t") ) { return "\\t"; }
   if( $c == ord("\b") ) { return "\\b"; }
   if( $c == ord("\a") ) { return "\\a"; }
   if( $c == 32 ) { return "  (space)"; }
   if( $c < 32 || $c >= 127 ) { return sprintf '\\x%02x', $c; }
   return chr($c);
}

# Output line with annotation.
sub output($$$)
{
   my ($line, $annotation, $label) = @_;

   if( defined($annotation) )
   {
      if( defined($label) )
      {
         $annotation = LABEL_PREFIX . "$label: $annotation";
      }
      $line =~ /^(.*?)(\s*)$/;
      print "$1  /* $annotation */$2";
   }
   else
   {
      print $line;
   }
}


# Annotate program in two passes: find all the branch targets in the first
# pass, then add comments for everything in the second pass.
my %branch_targets = ();
for(my $pass = 0; $pass < 2; $pass++)
{
   my $inside_header = 0;
   my $instruction_start = 0;
   my $bits = 0;
   my $ip = 0;
   for(my $i = 0; $i < scalar @lines; $i++)
   {
      # Skip header section(s).
      if( $lines[$i] =~ /#ifndef/ )
      {
         $inside_header = 1;
      }
      elsif( $lines[$i] =~ /#endif/ )
      {
         $inside_header = 0;
         $instruction_start = $i + 1;
         $bits = 0;
      }
      if( $inside_header )
      {
         print $lines[$i] if $pass == 1;
         next;
      }

      if( $lines[$i] =~ /\b[zs]/ )
      {
         if( $i - $instruction_start == 8 )
         {
            # End of output instruction.
            if( $pass == 1 )
            {
               my $char = ($bits & 0xff) ^ 0x20;
               my $annotation = "output " . to_char($char);
               output($lines[$i],
                      $annotation,
                      exists $branch_targets{$ip} ? $ip : undef);
            }

            $bits = 0;
            $instruction_start = $i + 1;
            $ip++;
         }
         elsif( $i - $instruction_start == 17 )
         {
            # End of branch instruction.
            my $length = ($bits & 0xff) + 3;
            my $target = $ip - ((($bits >> 9) & 0xff) + 1);
            if( $pass == 1 )
            {
               my $annotation = "goto " . LABEL_PREFIX .
                                "$target, output $length bytes";
               output($lines[$i],
                      $annotation,
                      exists $branch_targets{$ip} ? $ip : undef);
            }
            else
            {
               $branch_targets{$target} = 1;
            }
            $bits = 0;
            $instruction_start = $i + 1;
            $ip += 2;
         }
         else
         {
            # Incomplete instruction, collect bits.
            print $lines[$i] if $pass == 1;
            $bits |= 1 << ($i - $instruction_start);
         }
      }
      else
      {
         print $lines[$i] if $pass == 1;
      }
   }
}
