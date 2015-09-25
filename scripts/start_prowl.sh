#!/usr/bin/env bash
PROWL_SESSION=prowl
GOTTY_LOG=gotty.log

while true
do
  echo prowl has started TODO: need a clean up script for CTRL-C or other signals

  echo create tmux session if it doesn\'t exist
  tmux has-session -t $PROWL_SESSION > /dev/null 2>&1 || tmux new-session -d -s $PROWL_SESSION docker-machine ssh dev

  # this won't work for b2d setups, thanks tianon for docker run incantation
  # tmux has-session -t $PROWL_SESSION > /dev/null 2>&1 || tmux new-session -d -s $PROWL_SESSION docker-machine ssh dev -- docker run -it --rm --privileged --net=host --pid=host -v /:/host debian:jessie chroot /host /bin/sh
  #
  # docker run \
  # -it           \ # interactive and pseudo terminal
  # --rm          \ # delete container on exit
  # --privileged  \ # see all devices, more info http://blog.docker.com/2013/09/docker-can-now-run-within-docker/
  # --net=host    \ # use host's network
  # --pid=host    \ # use hosts's PID name space
  # -v /:/host    \ # maps host's root to volume /host
  # debian:jessie chroot /host /bin/sh # chroot the user into /host jail
  # WARNING: this will allow student to edit your vps's root fs. need to make a custom chroot


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
