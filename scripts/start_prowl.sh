#!/usr/bin/env bash
PROWL_SESSION=prowl
GOTTY_LOG=gotty.log

while true
do
  echo prowl has started TODO: need a clean up script for CTRL-C or other signals

  echo create tmux session if it doesn\'t exist
  # vbox local testing - tmux has-session -t $PROWL_SESSION > /dev/null 2>&1 || tmux new-session -d -s $PROWL_SESSION docker-machine ssh dev
  tmux has-session -t $PROWL_SESSION > /dev/null 2>&1 || tmux new-session -d -s $PROWL_SESSION bash

  echo start gotty, logging to $GOTTY_LOG
  TMUX=tmux
  TMUX_COMMAND=attach
  TMUX_OPTS="-r -t" # attach client as readonly to a named session
  # TMUX_OPTS="-t" # attach client to a named session, with write access

  # nohup gotty --permit-write --once --index prowl.html $TMUX $TMUX_COMMAND $TMUX_OPTS $PROWL_SESSION > $GOTTY_LOG 2>&1 &
  # FIXME hardcoded address
  nohup gotty  --address 172.17.42.1 --index prowl.html $TMUX $TMUX_COMMAND $TMUX_OPTS $PROWL_SESSION > $GOTTY_LOG 2>&1 &


  # start control script
  echo starting proof of concept lesson
  ./poc.sh

  echo prowl has ended, sleeping for 30 seconds. now would be a good time hit 
  echo CTRL-C to exit
  sleep 30
done
