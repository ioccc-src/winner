#!/usr/bin/env bash
#
# try.sh - demonstration of 2025/ferguson

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy way.
#
[[ -z "$CC" ]] && CC="cc"

# make sure the program has been built
#
MAKE=$(command -v gmake)

# I run make clobber first so that temporary image files are wiped out (this
# means that if the program fails to allocate memory due to the user having
# facebook open :-) the output image will not exist so the script will exit).
# Okay so I also do || exit 1 on the lines of ./prog but in case I missed an
# example or the judges add to it (and forget to add the '|| exit 1' because
# they're human and we all make mistakes :-) ) this will solve the problem of
# 'image file already exists' so there's something to diff.
#
# Another reason I do clobber is so that the source maps are not incorrect (in
# diff -s - though I do it via a function as -s is not mandated by the standard)
# if someone reconfigures the colours.
#
# Of course since not every run of the program is to diff the || exit 1 on the
# ./prog runs is also useful. Maybe would be nice if I could do a diff on all
# images here but I ran into the problem of max submission size so I had to not
# include another map (which was really unfortunate as it was a nice and
# different equirectangular map of our Flat Hollow Earth! - a pretty amazing
# feat I should say) and I even got rid of another image that I had done diff
# with before just to make sure I didn't have any other problems.
#
# If you don't understand this then this might help you out. On macOS 26.0.0 on
# 16 January 2026 at 13.11.24 UTC:
#
#   $ du -hc *.ppm
#   2.1M	argentina.ppm
#   2.1M	china.ppm
#   2.1M	earth.ppm
#   1.5M	earth2.ppm
#   7.7M	total
#
# and 'earth2.ppm' was not included due to hitting the limit. In other words PPM
# images are rather big. This is why I converted some to PNG. Later on though I
# got rid of some images so I could fit more in as I wanted actual maps
# (earth2.ppm as what was above was omitted as I found an even better image).
#
${MAKE:=make} CC="$CC" clobber all >/dev/null || exit 1

# clear the screen
#
clear

do_diff()
{
    if [[ "$#" != 2 ]]; then
        echo "$0: error: expected two args, got $#" 1>&2
        exit 1
    fi
    if diff "$1" "$2"; then
        echo "Files $1 and $2 are identical" 1>&2
        return 0
    else
        echo "Files $1 and $2 are not identical" 1>&2
        exit 1
    fi
}

# try the program
#
# try specific known points on a different output file and then compare to
# make sure it's the same thing (as what I submitted)
#
echo "NOTE: as you try this program you should have earth.ppm open as a baseline." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog 40.0 117.0 earth.ppm argentina_out.ppm: "
echo 1>&2
echo 1>&2
./prog 40.0 117.0 earth.ppm argentina_out.ppm || exit 1
echo 1>&2
read -r -n 1 -p "Press any key to diff argentina_out.ppm with argentina.ppm: "
echo 1>&2
echo 1>&2
do_diff argentina.ppm argentina_out.ppm
echo 1>&2
echo "Now open argentina.ppm and argentina_out.ppm in a graphics viewer" 1>&2
echo "to visually inspect the Earth with the plottings." 1>&2
echo 1>&2

echo "Now we'll do the same but from Argentina to China." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog -40.0 -63.0 earth.ppm china.ppm: "
echo 1>&2
echo 1>&2
./prog -40.0 -63.0 earth.ppm china_out.ppm || exit 1
echo 1>&2
read -r -n 1 -p "Press any key to diff china_out.ppm with china.ppm: "
echo 1>&2
echo 1>&2
do_diff china.ppm china_out.ppm
echo 1>&2
echo "Now open china.ppm and china_out.ppm in a graphic viewer" 1>&2
echo "to visually inspect the Earth with the antipodal arrows." 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog 49.68000 -1.22000 earth.ppm antipodes.ppm: "
echo 1>&2
echo 1>&2
./prog 49.68000 -1.22000 earth.ppm antipodes.ppm || exit 1
echo 1>&2
echo "Now open antipodes.ppm in a graphics viewer." 1>&2
echo 1>&2

echo "The next one we'll have you come up at the Chicxulub impact crater in the" 1>&2
echo "Yucatán Peninsula, where the asteroid wiped out the dinosaurs (and approx. 75%" 1>&2
echo "of all wildlife), 66Mya (66 million years ago)." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog -21.40000 90.483300 earth.ppm chicxulub.ppm: "
echo 1>&2
echo 1>&2
./prog -21.40000 90.483300 earth.ppm chicxulub.ppm || exit 1
echo 1>&2
echo "Now open chicxulub.ppm in a graphics viewer and weep for the dinosaurs." 1>&2
echo 1>&2

echo "Now let's make YOU the asteroid (you horrible person you!)." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog 21.400000 -89.516700 earth.ppm asteroid.ppm: "
echo 1>&2
echo 1>&2
./prog 21.400000 -89.516700 earth.ppm asteroid.ppm || exit 1
echo 1>&2
echo "Now open asteroid.ppm and look at what you have done!" 1>&2
echo "And yes, the value printed is where the asteroid would have landed if it did not blow up" 1>&2
echo "and managed to go through the Earth far enough and up through the ocean." 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog 19.0 -155.0 earth.ppm botswana.ppm: "
echo 1>&2
echo 1>&2
./prog -19.0 -155.0 earth.ppm botswana.ppm || exit 1
echo 1>&2
echo "Now open botswana.ppm in a graphics viewer." 1>&2
echo "Did you notice that the source is at Mauna Loa, Hawai'i County, Hawaii?" 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog -1.70000 22.80000 earth.ppm line.ppm: "
echo 1>&2
echo 1>&2
./prog -1.70000 22.80000 earth.ppm line.ppm || exit 1
echo 1>&2
echo "Now open line.ppm in a graphics viewer." 1>&2
echo "Fun fact: the Line Islands are the first place to become a new day!" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog -0.195833 3.520833: "
echo 1>&2
echo 1>&2
./prog -0.195833 3.520833 earth.ppm baker.ppm || exit 1
echo 1>&2
echo "Now open baker.ppm in a graphics viewer." 1>&2
echo "Fun fact: Baker Island is the last place to become a new day!" 1>&2
echo 1>&2
echo "Let's do another. This time the destination is an undisclosed location," 1>&2
echo 1>&2
echo "from 10 Downing Street, at 51.503488, -0.127696." 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog 51.503488 -0.127696 earth.ppm undisclosed.ppm: "
echo 1>&2
echo 1>&2
./prog 51.503488 -0.127696 earth.ppm undisclosed.ppm || exit 1
echo 1>&2
echo "Now open undisclosed.ppm in a graphics viewer and weep for 10 Downing St." 1>&2
echo "Weep for joy, I mean. Did you think I meant otherwise?" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog 2.597580 -144.082030 earth.ppm natron.ppm: "
echo 1>&2
echo 1>&2
./prog 2.597580 -144.082030 earth.ppm natron.ppm
echo 1>&2
echo "Now open natron.ppm and look at where you come up. That is Lake Natron and" 1>&2
echo "it turns most animals into 'statues' through calcification. Some incredible" 1>&2
echo "photos can be found if you search google images for: Lake Natron statues." 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog -0.00000 -180.00000 earth.ppm null.ppm: "
echo 1>&2
echo 1>&2
./prog -0.00000 -180.00000 earth.ppm null.ppm || exit 1
echo 1>&2
echo "Now open null.ppm in a graphics editor. Whatever you do don't dereference it!" 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog 24.486000 133.324500 earth.ppm island.ppm: "
echo 1>&2
echo 1>&2
./prog 24.486000 133.324500 earth.ppm island.ppm
echo 1>&2
echo "Fun fact: if you ended up where island.ppm shows you, you would be dead very" 1>&2
echo "quickly because that is Snake Island, where thousands of golden lancehead vipers" 1>&2
echo "are. It is illegal to visit it so if you wish to do so you should go through the" 1>&2
echo "Earth instead!" 1>&2
echo 1>&2
echo "BTW: did you notice how the arrows have to be scaled so they can be seen? Obviously" 1>&2
echo "Snake Island is located off the coast of Brazil and not on the mainland!" 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog -51.895170 -178.519500 earth.ppm sealand.ppm: "
echo 1>&2
./prog -51.895170 -178.519500 earth.ppm sealand.ppm
echo "Now open sealand.ppm and see the smallest 'country' in the world!" 1>&2
echo "Again, notice the scaling of the arrows." 1>&2
echo 1>&2
echo "Fun fact: this 'country' is Sealand, which is basically a platform in the sea" 1>&2
echo "that was used during the Second World War; it is more correctly called a 'micronation'," 1>&2
echo "though there are some who aggressively against even that." 1>&2
echo "For more fun details see: https://sealandgov.org/" 1>&2
echo 1>&2
echo "We have a few more to do despite the fact that many (if not most) people are" 1>&2
echo "probably bored at this point :-)" 1>&2
echo 1>&2
echo "First we will show Iowa's antipodal point." 1>&2
echo 1>&2

read -r -n 1 -p "Press any key to run: ./prog -42.032974 86.418457 earth.ppm iowa.ppm: " 1>&2
echo 1>&2
./prog -42.032974 86.418457 earth.ppm iowa.ppm
echo 1>&2
echo "Now open iowa.ppm in a graphics viewer and notice the accuracy there." 1>&2
echo "Once you've done this let's show it on our Flat Earth." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog -42.032974 86.418457 flat-earth.ppm flat-iowa.ppm: "
echo 1>&2
./prog -42.032974 86.418457 flat-earth.ppm flat-iowa.ppm
echo 1>&2
echo "Now open flat-iowa.ppm in a graphics viewer and observe just how submerged everything" 1>&2
echo "is! This is because the water has nowhere to go on our Flat Earth so everything has been" 1>&2
echo "drowned." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog 34.95000 29.50000 earth.ppm mysterious.ppm: "
echo 1>&2
echo 1>&2

./prog 34.95000 29.50000 earth.ppm mysterious.ppm || exit 1
echo 1>&2
echo "Now open mysterious.ppm in a graphics viewer and please say hello to" 1>&2
echo "Captain Nemo for me!"
echo 1>&2
echo "Now let's redo the last one but without clouds, using noclouds.ppm instead of earth.ppm." 1>&2
echo 1>&2
read -r -n 1 -p "Press any key to run: ./prog 34.95000 29.50000 noclouds.ppm mysterious_noclouds.ppm: "
echo 1>&2
./prog 34.95000 29.50000 noclouds.ppm mysterious_noclouds.ppm || exit 1
echo 1>&2
echo "Now open mysterious_noclouds.ppm in a graphics viewer and say farewell to" 1>&2
echo "Captain Nemo for me." 1>&2
echo 1>&2

read -r -n 1 -p "Do you wish to try 1992/westley with this program (y/n - default: y)? " ans
echo 1>&2
if [[ "$ans" != "n" && "$ans" != "N" ]]; then
    ./westley.sh
fi
echo 1>&2
echo "NOTE: this next one, if you do it, will take A LONG time, but it's amusing." 1>&2
echo "IF you opt for it you might wish to early on open the file in a viewer that either" 1>&2
echo "repeatedly reloads it or repeatedly reload it yourself (e.g. in macOS you could do" 1>&2
echo "'open fun.ppm' throughout the run of the script." 1>&2
echo 1>&2
read -r -n 1 -p "Do you wish to try ./coords.sh (y/n - default: n)? " ans
echo 1>&2
if [[ "$ans" == "y" || "$ans" == "Y" ]]; then
    ./coords.sh
fi
echo 1>&2

echo "Safe travels, have a nice day and don't forget your diving gear!" 1>&2
echo "If you don't drown. Which let's face it. You probably will." 1>&2
echo "If you don't die in a magma chamber first. And you might, assuming" 1>&2
echo "you get so far. Which you won't. Unless you start at Þríhnúkagígur." 1>&2
echo 1>&2
exit 0
