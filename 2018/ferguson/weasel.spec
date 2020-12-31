%global debug_package %{nil}

Name:           weasel
Version:        0.0.1
Release:        3%{?dist}
Summary:        Implementation of Richard Dawkins's Weasel program

License:        Creative Commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
URL:            http://ioccc.xexyl.net/weasel
Source0:        weasel.tar.bz2

BuildRequires:  gcc make
AutoReq:	1

%description
    It is an implementation of Richard Dawkins' Weasel program. According 
    to Wikipedia in chapter three of his book The Blind Watchmaker 
    Dawkins wrote:
	
	I don't know who it was first pointed out that, given enough time,
	a monkey bashing away at random on a typewriter could produce all
	the works of Shakespeare. The operative phrase is, of course,
	given enough time. Let us limit the task facing our monkey
	somewhat.  Suppose that he has to produce, not the complete works
	of Shakespeare but just the short sentence 
	    'Methinks it is like a weasel', 
	and we shall make it relatively easy by giving him a typewriter
	with a restricted keyboard, one with just the 26 (capital) letters,
	and a space bar. How long will he take to write this one little
	sentence?

    This version has some additional features like a more complicated
    keyboard, a couple Easter eggs and the ability to change the target
    string amongst others. See weasel(1) for more information.

%prep
%setup -n weasel

%build
make weasel weasel-simple
mv -f hint.txt hint.text 2>/dev/null || :

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT%{_bindir} $RPM_BUILD_ROOT%{_usrsrc}/weasel
install -p -m 755 weasel $RPM_BUILD_ROOT%{_bindir}/weasel
install -p -m 755 weasel-simple $RPM_BUILD_ROOT%{_bindir}/weasel-simple
install -p -m 755 test.sh $RPM_BUILD_ROOT%{_usrsrc}/weasel/test.sh
install -m 644 test-strings.txt $RPM_BUILD_ROOT%{_usrsrc}/weasel/test-strings.txt
install -m 644 prog.c -D $RPM_BUILD_ROOT%{_usrsrc}/weasel/weasel.c
ln -s weasel.c $RPM_BUILD_ROOT%{_usrsrc}/weasel/prog.c
install -m 644 Makefile -D $RPM_BUILD_ROOT%{_usrsrc}/weasel
install -m 644 prog-simple.c -D $RPM_BUILD_ROOT%{_usrsrc}/weasel/weasel-simple.c
ln -s weasel-simple.c $RPM_BUILD_ROOT%{_usrsrc}/weasel/prog-simple.c
install -m 644 weasel.1 -D $RPM_BUILD_ROOT%{_mandir}/man1/weasel.1
install -m 644 hint.html -D $RPM_BUILD_ROOT%{_docdir}/weasel/weasel.html
install -m 644 hint.text -D $RPM_BUILD_ROOT%{_docdir}/weasel/weasel.markdown
install -m 644 hint.css -D $RPM_BUILD_ROOT%{_docdir}/weasel/hint.css
install -m 644 FILES -D $RPM_BUILD_ROOT%{_docdir}/weasel/FILES

%files
%{_bindir}/weasel*
%{_usrsrc}/weasel/*
%doc
%{_mandir}/man1/*
%{_docdir}/weasel/*

%changelog
* Tue May 01 2018 Cody Ferguson <weasel@xexyl.net> 0.0.1-3
- Add FILES file.

* Mon Apr 30 2018 Cody Ferguson <weasel@xexyl.net> 0.0.1-2
- General fixes.

* Mon Apr 16 2018 Cody Ferguson <ioccc@xexyl.net> 0.0.1-1
- Initial spec file.
