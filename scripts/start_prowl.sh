#!/usr/bin/env bash
PROWL_SESSION=prowl
GOTTY_LOG=gotty.log

while true
do
  echo prowl has started TODO: need a clean up script for CTRL-C or other signals

  echo create tmux session if it doesn\'t exist
  tmux has-session -t $PROWL_SESSION > /dev/null 2>&1 || tmux new-session -d -s $PROWL_SESSION docker-machine ssh dev

  echo start gotty, logging to $GOTTY_LOG
  # TODO : client exit on client disconnect doesn't always work, trap for 
  # 2015/09/23 08:16:34 Command exited for: 127.0.0.1:57682
  # 2015/09/23 08:16:34 Connection closed: 127.0.0.1:57682
  # NOTE : I exit on disconnect is a bad UX, what if you're travelling and the
  # connection drops? Or your broadband isn't very reliable.
  TMUX=tmux
  TMUX_COMMAND=attach
  TMUX_OPTS="-r -t" # attach client as readonly to a named session
  # TMUX_OPTS="-t" # attach client to a named session

  # clear up nohup
  nohup gotty --permit-write --once --index prowl.html $TMUX $TMUX_COMMAND $TMUX_OPTS $PROWL_SESSION > $GOTTY_LOG 2>&1 &

  # start control script
  echo starting proof of concept lesson
  ./poc.sh

  echo prowl has ended, sleeping for 30 seconds. now would be a good time hit 
  echo CTRL-C to exit
  sleep 30
done
