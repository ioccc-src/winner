Best of Show:

    Jari Arkko
    Kauppalantie 25A7,
    02700 Kauniainen,
    Finland

    http://www.arkko.com

    Jyrki Holopainen
    Forsellesintie 1-3A10,
    02700 Kauniainen,
    Finland

    http://personal.eunet.fi/pp/halo/


Judges' Comments:

    To build: (You will need X11 header files and libraries installed to
                build this program)

       make jarijyrki

    To run:  (You will need a system capable of displaying the results of
              X Window programs)

       ./jarijyrki < sheet1.info > myedits.info

    This entry is one of those that makes you wonder why some commercial
    software needs tens to hundreds of megabytes to install!  This entry
    does not simply do the basics, it includes graphing features.  All this
    program needs now is a flight simulator!


Selected Author's Comments:

    1. OVERVIEW

    This program is an X-Windows based spreadsheet program.
    The main functions it supports are:

    	* Text cells
    	* Numeric cells
    	* Arithmetic operations: + - * /
    	* Pie charts
    	* Histograms
    	* Cell editing
    	* Formula line
    	* Dynamic recalculation
    	* Error detection
    	* Recursion detection
    	* Movement within the spreadsheet with cursor keys
    	* Movement within the spreadsheet with mouse
    	* Scrolling
    	* Loading and saving spreadsheets
    	* Visual style configuration

    2. USAGE INSTRUCTIONS

    2.1. Quick Guide

    Starting:	./jarijyrki < sheet1.info > myedits.info
    Stopping:	Esc
    Movement:	Click mouse or cursor keys
    Editing:	Currently selected cell is always in edit state.
                Press any key to add a character at the end of the
                formula; press BackSpace to delete the last one.
    Formulas:	123.45
                A1 A2 +
                B1 B2 -
                C1 C2 *
                D1 D2 /
    Pie charts: A1 A2 A3 ... An @
    Histograms:	A1 A2 A3 ... An !

    2.2. Starting and Loading Spreadsheets

    To start the spreadsheet program with an existing
    spreadsheet, use the following command line:

        ./jarijyrki < sheet1.info

    The file sheet1.info has been provided as an example.
    This file contains a set of financial numbers and two
    graphical entities - a pie chart and a histogram - based
    on them. We recommend starting the use of the program
    from this file, as a way to study and learn the formula
    language supported by the program.

    To start the program with an empty sheet, use

        ./jarijyrki < /dev/null

    [Alternatively, /dev/zero could be used but that may not exist
    on all systems.]

    2.3. Exiting and Saving Spreadsheets

    Normally the user obviously wants to edit the spreadsheet.
    After the spreadsheet program finishes, it outputs the
    edited spreadsheet to the standard output. Hence, when
    the spreadsheet window has come up, you've made your changes,
    and you press the Esc key the program finishes. To save
    the results in a file, the following typical command line
    would be used:

        ./jarijyrki < sheet1.info > myedits.info

    2.4. Visual Overview

    On top of the window the Formula Area shows the formula (or text)
    of the currently selected cell. The program starts with A1 as
    being the current cell. Below the Formula Area is the Column
    Letters Area: A, B, and so on. Correspondingly, on the left
    side of the window is the Row Numbers Area: 1, 2, and so on.
    The rest of the window is dedicated to the actual spreadsheet
    cells.

    The example spreadsheet, sheet1.info, provided with this
    program contains two sets of numbers in the visible area
    of the spreadsheet. The top set of numbers forms the
    product-by-product turnover breakdown of an imaginary
    company. Below it is the yearly development of the
    company profits. On the top right corner is a pie chart
    showing the turnover breakdown in graphical form, and
    on the bottom right corner is a histogram showing the
    yearly development. If you scroll the window you can
    see additional data from the spreadsheet.

    2.5. Movement and Scrolling

    Use cursor keys to move left, right, up, and down among the cells.
    [Note that it is not possible to move around the formula; the
    formula can only be edited from its end by adding or removing
    characters.] You may also click the mouse on a cell to cause it
    to be activated as the current one.

    Going beyond the borders of the window results in scrolling
    the current view. It is not possible to go up from first row
    or left from the first column; but it is possible to wrap back
    to start from the last row and last column.

    2.6. Formula

    The spreadsheet formulas operate on a stack. Operands of an
    operation (e.g. plus) are first pushed to the stack and then
    the operation is performed. If a formula on a cell produces
    *exactly* one result then that is shown in the cell. Otherwise,
    the formula is interpreted as a string and shown as it is.

    An example of a simple formula, simply specifying a number
    is

        123.50

    Another simple formula refers to a cell:

        A1

    This particular example formula referred to the first cell of
    the first row in the spreadsheet. Arithmetic operations require
    both arguments:

        A1 A2 +
        B1 B2 *
        C1 C2 -
        D1 D2 /

    More complex formulae can be constructed by combining these
    simple ones:

        A1 A2 + 2 *

    This example calculated the sum of the cells A1 and A2, and then
    multiplied the result by two.

    The currently selected cell is always in a state where it can
    be edited. Press any key to add a character at the end of the
    formula; press BackSpace to delete the last one. Any resulting
    recalculations are immediately visible. [Note how much nicer
    this feature is as you get used to it, compared to the behaviour
    of certain commercial spreadsheet programs.]

    2.7. Graphical Formulas

    The program supports two types of graphical representations of the
    data in the cells: pie charts and histograms. The pie chart can
    consist of any number of slices, and is constructed by putting
    the pie amounts in stack and using the @ operator. The program
    automatically computes the relative size of the slices.

        A1 A2 A3 A4 @

    This example would draw a pie slice of four cells, A1 to A4.
    The pie formula is shown above the pie for reference.

    The histograms are drawn in a similar manner, by using the !
    operator:

        A1 A2 A3 A3 !

    2.8. Errors in Formulas

    The program detects recursive reference attempts, references
    cells not containing a numerical value, attempts to define
    formulas with zero, two, or more results remaining in the stack,
    and syntax errors of formulas. Note that typically as the user
    types in a formula, it toggles between valid and invalid forms
    dynamically as all single character changes are immediately
    taken in account. This is not dangerous, just complete the
    formula and view the results.

    Errors are signalled by showing the formula on a cell instead
    of the numerical value supposedly returned by it.

    Division by zero results in an IEEE Inf number.

    2.9. Compilation Parameters and Configuration

    This section explains the meaning and rationale for the
    compile time parameters:

    -DC=XK_Up
    -DL=XK_Down
    -DO=XK_Left
    -DV=XK_Right
    -DR=XK_Escape
    -D_=XK_BackSpace

    These definitions can be used to change the user interface
    of the program with respect to special keys. The four first
    ones define the movement operations and the latter two ones
    define the program termination and character deletion keys.
    Typical modifications to these parameters include changing
    character deletion to the key the user is most familiar with,
    which could also be XK_Delete. XK_Escape might be better
    in some cases as one of the function keys. Likewise for the
    cursor keys.


    -DU=40

    This parameter defines the maximum dimensions of the stored
    and handled spreadsheet (but see section 4.4 for a warning
    about changing this without thinking about the consequences!).


    -DT=98

    This parameter defines the maximum length of a formula in one
    cell. Note the warning in 4.4.


    -Dz="(T+1)*U*U"

    Defines the number of bytes in a spreadsheet file. The number is
    automatically adjusted when the spreadsheet size parameters are
    changed. Note the warning in 4.4.


    -DQ=80
    -DS=20

    These two parameters define the visual dimensions of a cell.
    Changing these may be necessary on your system if the default
    font sizes differ from those in the systems we've tested the
    program with. S also defines the size of the left (x1) and top
    margins (x2).


    -DN=10

    This is the x-indentation of text inside a cell. Changing
    this may be necessary to suit other font sizes and
    different X environments.


    -DB=5

    This is the y-indentation of text inside a cell. Changing
    this may be necessary to suit other font sizes and
    different X environments.


    -DG=23

    This parameter is the number of cell rows visible at one
    time.


    -Dp=7

    This parameter is one smaller than the number of cells columns
    visible at one time.


    -DM="((p+1)*Q)+S"
    -DH="(G*S)+S+S"

    These parameters are the window x and y sizes of the spreadsheet
    program window. With these definitions, they are automatically
    reflecting the at-one-time-visible cell row/column amounts.
    Hence, we recommend changing the G and p parameters if you want
    to change the window size in normal cases. Experimentation with
    M and H can be used to get other types of effect such as adding
    a margin also at the bottom of the window.

    3. IMPLEMENTATION

    It's better to just read the code. But note the use of
    stack in the implementation of @ and ! operators, and note
    the use of *#i in one of the macros [can you see why?].
    Extreme compression has been the key in writing this
    program. With compression have come the use of ASCII code
    numbers instead of character constants and so on. [This
    particular obfuscation is not really a desirable one as
    it is not completely portable. But it certainly was a
    necessary one.]

    What does or does not "i(=)" do and why?

    4. WARNINGS AND CAVEATS

    4.1. X11 Paths in Compilation

    The given build file may have to be edited to insert correct
    library and include file path names.

    4.2. Font Sizes

    We've tested the program with limited amount of X servers.
    It is possible that other systems use default font sizes or
    other parameters that cause the visual looks to be different
    or perhaps even unusable; if this happens, changing compile-time
    parameters explained in section 2.8 may help.

    4.3. Screen Sizes

    The size of the window as it comes up - a parameter as defined
    in compile-time - has been set suitable for a small laptop screen.
    Larger screens may benefit from setting these parameters higher.
    Smaller screens require changing the parameters so that all of the
    window becomes visible.

    4.4. Spreadsheet Dimension Changes

    The size of the read, manipulated, and stored spreadsheets is
    defined by a compile time parameter. However, changing this
    parameter is not entirely trivial. The following constraints
    apply:

    (a) Horizontal (alphabet) dimension handling will always be
    A to Z regardless of the actual allocated memory area.

    (b) Any change in the dimension parameter renders existing
    spreadsheet files unsuitable.

    4.5. ASCII Reliance

    The software relies on running on ASCII-based code system.
    Why? Because "32" is shorter than "' '".

    4.6. Command Line Single Character Defines

    The use of single character (e.g. G or p) for a -D option
    may break certain systems, if those characters are used
    in the included X header files in certain kinds of places.
    If this happens, you may move the offending character to
    a new name by exchanging it on the command line and in
    the program with another character. Note that there are
    *no* free characters in the program currently.

