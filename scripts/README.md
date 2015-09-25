# Scripts

## Project related

- setup_prowl.sh - installs pre-reqs for prowl, and provides instructions
    for setting up prowl user account.
- start_prowl.sh - the main script that tmux session, spins up gotty and 
    calls out to poc.sh
- poc.sh - the Professor Owl proof of concept script. Interacts with tmux,
    has some of the test dialogue from Professor Owl. Also demonstrates how
    to toggle Student session to read-only mode.
- say.sh - script interface to tmux display-message command.
- demo.sh - runs hello-world image repeatedly, useful for read-only demos
- prowl.html - custom index page for gotty

## Hackday related

These scripts were used to archive the hackday process by timelapsing desktop 
screencaps. I should move these into their own repo...

- timelapse_desktop.sh - OSX only, grabs the desktop every 60 seconds and 
    saves as a datetime stamped png.
- image2video.sh - Converts images into a mpeg4 video. I've tried to add a 
    delay, but it appears to be ignored by imagemagick's convert.

