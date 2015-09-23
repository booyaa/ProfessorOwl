#!/usr/bin/env bash +x
PROWL_SESSION=prowl
echo prowl has started
echo create prowl session
tmux has $PROWL || tmux new -d -s prowl

echo start gotty
# TODO : client exit on client disconnect doesn't always work, trap for 
# 2015/09/23 08:16:34 Command exited for: 127.0.0.1:57682
# 2015/09/23 08:16:34 Connection closed: 127.0.0.1:57682
# NOTE : I exit on disconnect is a bad UX, what if you're travelling and the
# connection drops? Or your broadband isn't very reliable.
TMUX=tmux
TMUX_COMMAND=attach
# TMUX_OPTS="-r -t" # attach client as readonly to a named session
TMUX_OPTS="-t" # attach client to a named session
gotty --permit-write --once --index prowl.html $TMUX $TMUX_COMMAND $TMUX_OPTS $PROWL_SESSION

echo prowl has stopped

