# How to upload your submission to the IOCCC

**IMPORTANT NOTE**: The [IOCCC submit server](https://submit.ioccc.org)
is only ready for submissions
**ONLY WHEN THE CONTEST IS [open](../faq.html#open)**.

See [current status of the IOCCC](../status.html) for details on the contest status.
**IMPORTANT NOTE**: When the contest is [closed](../faq.html#closed), the
[IOCCC submit server](https://submit.ioccc.org)
might be offline and unreachable as a website.

To login, open [https://submit.ioccc.org](https://submit.ioccc.org)
in your browser. Fill in your login credentials and click "Login".
It might look something like:

<img src="../png/submit.login.png"
 alt="submit server login page screenshot"
 width=710 height=344>

**NOTE**: if the contest is NOT open you will see something like this instead:

> The contest is NOT yet open for submissions.<br>
> Sorry (tm Canada 🇨🇦), the IOCCC is not yet open.<br>
> The IOCCC is scheduled to open at 2025-03-05 23:19:17.131107 UTC.<br>
>
> Message(s):<br>
> The IOCCC is not yet open for submissions.

Assuming it is open, and if you've not logged in before, you'll have to change
your password first. See the file [pw-change.html](pw-change.html) for more
details. After that you will have to log back in.

Once you've logged in, you will see submit slots. Each slot is for one
submission so if you update a submission, make sure you choose the right one so
you do not replace the wrong one!

Here is what it looks like without any uploads and no slot selected:

<img src="../png/submit.slots.png"
 alt="submit server submission slots list to select from with no slot selected
 screenshot" width=710 height=806>

Select a slot and then select a file by clicking the button "Choose File". After
doing this, it should look something like:

<img src="../png/submit.slot-file.png"
 alt="submit server submission slot selected with a file chosen to be uploaded screenshot"
 width=717 height=865>

If you need to change the file to upload, you can mouseover the file and click
it. If you wait a moment it'll show the current filename.

Once you're certain you have selected the correct file, click "Submit", below
the file selection step.

When it's uploaded it should say something like:

> • Uploaded file: submit.9971ada4-b6ae-427d-a7ec-e67a30362cdb-0.1740838915.txz

And in the slot it will give you important details like:

- the status of the submission (on upload it will say: `"uploaded file into
slot"`).
- the filename, which will be in the correct format, assuming you used
`mkiocccentry(1)` which is **HIGHLY** recommended so that you do not break [Rule
17](rules.html#rule17)!
- the file length, which `txzchk(1)` will also verify (the file itself and the
tarball listing).
- the upload date.
- the SHA256 hash of the file.

Now if you're done, log out.

If, on the other hand,, you upload a file that is too big you will see something
like:

> The file size of N exceeds the maximum size of 3999971.

And if you try uploading an empty file you'll instead see:

> The must not be empty.

And if you see something like:

> Filename for slot: 0 must match this regular expression: `^submit.dd3d30c2-d8d0-4506-adcd-d4e029147f39-0\.[1-9][0-9]
{9,}\.txz$`

where `0` is the slot and `dd3d30c2-d8d0-4506-adcd-d4e029147f39-01` is the UUID
then you **MUST** upload a properly named XZ compressed tarball, **MAKING SURE** you
package it with `mkiocccentry`!

If later on you log in and see something like:

> Status: server slot error code: 1! Use mkiocccentry to rebuild and resubmit to
this slot.

or:

> Status: submit file failed the txzchk test! Use mkiocccentry to rebuild and resubmit to this slot.

... or **ANY** other error then you **MUST FIX** your submission, repackage your
tarball with `mkiocccentry` and upload to the same slot again! If you do not fix
this your submission **WILL** be rejected for violating [Rule
17](rules.html#rule17)!

After the submission deadline is reached, you can log in to check the status of
your submissions. This is what it will say when the judges have verified
that your tarball / submission has been validated (NOT judged), by `txzchk(1)`
and `chkentry(1)`:

> Status: the format of this submission has been validated.

**IMPORTANT**: this does **NOT** mean that your submission does not violate the
rules or that everything is OK once the tarball is extracted; it simply means
the tests performed by the tools passed. If you find a flaw in the tool and
abuse it and the tests pass then you stand a significant chance of having your
submission rejected for violating [Rule 17](rules.html#rule17), even if the
tests passed.

For details on `txzchk`, see the
FAQ on "[txzchk](../faq.html#txzchk)".

For details on `chkentry`, see the
FAQ on "[chkentry](../faq.html#chkentry)".

If you need more information on the two JSON files, see
FAQ on the [".info.json file](../faq.html#info_json)"
and the
FAQ on the "[.auth.json file](../faq.html#auth_json)".


<!--

    Copyright © 1984-2024 by Landon Curt Noll. All Rights Reserved.

    You are free to share and adapt this file under the terms of this license:

        Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

    For more information, see:

        https://creativecommons.org/licenses/by-sa/4.0/

-->
