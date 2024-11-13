# maki
Offensive security tool, dumbshell upgrader!

## What for?
Maki makes it possible to automate the upgrade of your initial foothold shell to fully interactive shells.
`CTRL+C` works without killing your shell so **no more frustrations**.
**WARNING**: maki may ruin your current shell session as it is still in beta testing phase. Make sure to run it on a separate session than your current terminal workspace.

## How to use
Simply run it as a listener on your local machine, then run any reverse shell on your target machine
```
# Listens on 0.0.0.0 (any) by default
./maki.sh --port 7878
```
