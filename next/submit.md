# How to upload your submission to the IOCCC

**IMPORTANT NOTE**: The [IOCCC submit server](https://submit.ioccc.org)
is only ready for submissions
**ONLY WHEN THE CONTEST IS [open](../status.html#open)**.

See [current status of the IOCCC](../status.html) for details on the contest status.
**IMPORTANT NOTE**: When the contest is [closed](../status.html#closed), the
[IOCCC submit server](https://submit.ioccc.org)
may be offline and unreachable as a web site.

The following steps should be taken, in order to upload your `mkiocccentry` xz
compressed tarball, to change the file (if you need to upload a different file
or you have updated the submission), and to check the status of it after the
contest closes:

First, open the web page in your browser. It should look like this:
With the login id and password already input, It should look something like
this:

<img src="../png/submit-server-login.png"
 alt="submit server login screen"
 width=710 height=562>

The login is the UUID you were provided when you registered for the IOCCC and
the password is the initial password you were provided with. Click "Login".

If this is the first time you have logged in with this UUID, you will
be required to change your password.

Assuming everything is fine, it should look something like:

<img src="../png/submit-server-first-login.png"
 alt="submit server password change required"
 width=710 height=808>

As you can see, you have to change your password. Put in your login (UUID
username), your old (initial) password and a new password. For instance:

<img src="../png/submit-server-change-passwd.png"
 alt="submit server changing password"
 width=710 height=808>

Click "Change Password".

Once this is done, you will have to log in again. Using the UUID login and the
new password:

<img src="../png/submit-server-passwd-changed.png"
 alt="submit server password changed"
 width=710 height=344>

.. click "Login".

Once you've logged in, you will see submit slots. Each slot is for one
submission so if you update a submission, make sure you choose the right one so
you do not overwrite the wrong one!

Here is what it looks like without any uploads and no slot selected:

<img src="../png/submit-server-slots.png"
 alt="submit server slots"
 width=710 height=806>

Select a slot and then select a file by clicking the button "Choose File". After
doing this, it should look something like:

<img src="../png/submit-server-slot-file.png"
 alt="submit server slot and file selected"
 width=717 height=865>

If you need to change the file to upload, you can mouseover the file and click
it. If you wait a moment it'll show the current filename. It will look something
like this:

<img src="../png/submit-server-change-file.png"
 alt="submit server change file"
 width=717 height=865>

Once you're certain you have selected the correct file, click "Submit", below
the file selection step.

When it's uploaded it should look something like this:

<img src="../png/submit-server-submission-uploaded.png"
 alt="submit server submission uploaded"
 width=717 height=525>

Here you see the details, in particular:

- the status of the submission
- the filename, which will be in the correct format, assuming you used
`mkiocccentry(1)` which is **HIGHLY** recommended so that you do not break [Rule
17](rules.html#rule17)!
- the file length, which `txzchk(1)` will also verify (the file itself and the
tarball listing)
- the upload date
- the SHA256 hash of the file

Now if you're done, log out.

After the submission deadline is reached, you can log in to check the status of
your submissions. Here is what it will look like when the judges have verified
that your tarball / submission has been validated (NOT judged), by `txzchk(1)`
and `chkentry(1)`.:

<img src="../png/submit-server-status-updated.png"
 alt="submit server status updated"
 width=717 height=217>

For details on `txzchk`, see the
FAQ on "[txzchk](../faq.html#txzchk)".

For details on `chkentry`, see the
FAQ on "[chkentry](../faq.html#chkentry)".

If you need more information on what `chkentry` checks, see the
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
