#!/usr/bin/env bash
# further reading: http://www.tldp.org/LDP/abs/html/exit-status.html
# http://stackoverflow.com/questions/90418/exit-shell-script-based-on-process-exit-code


while true
do
  CLIENTS=$(tmux lsc | grep -E 'prowl.*(ro)')
  STUDENT_ID=${CLIENTS%:*}

  echo clients: $CLIENTS
  echo student tty: $STUDENT_ID

  if [[ ! -z $STUDENT_ID ]]; then
      break;
  fi

  echo sleeping for 5 seconds...
  sleep 5 
done

# for testing
# echo fall through
# tmux kill-server
# exit

# clear
tmux send-keys C-u
tmux send-keys 'clear' C-m
echo say hi
tmux send-keys 'Hi my name is Professor Owl, I am going to teach you how to Docker!'
sleep 5
tmux send-keys C-u

tmux send-keys "Let's run the hello-world image"
sleep 5
tmux send-keys C-u

echo run hello-world image
tmux send-keys "docker run -it --rm hello-world" C-m
sleep 5

echo say that was easy, wasnt it?
tmux send-keys "That was easy, wasn't it?"
tmux send-keys C-u

echo now let the student have a go, removing lock
tmux send-keys "Now your turn. DEBUG: lock off"
sleep 5
tmux send-keys C-u

#TODO snap shot docker ps -a
tmux switch-client -c $STUDENT_ID -r

tmux display-message -c $STUDENT_ID "30 seconds left"
echo 30 seconds
sleep 10

tmux display-message -c $STUDENT_ID "20 seconds left"
echo 20 seconds
sleep 10

tmux display-message -c $STUDENT_ID "10 seconds left"
echo 10 seconds
sleep 5

tmux display-message -c $STUDENT_ID "5 seconds left"
echo 5 seconds

# FIXME: still returns 0, despite local test after docker run returning 1
echo User exit code: $?
tmux switch-client -c $STUDENT_ID -r
tmux send-keys C-u

#TODO diff snap shot of docker ps -a, is there a new container is it based on hello-world?
#TODO capture and display buffer. was the student successful?
#TODO capture exit code of (vital you get this before you lock the screen)
tmux send-keys "Well done, this concludes our lesson. DEBUG: lock on"
sleep 15
tmux send-keys C-u

# this will kill gotty off
tmux kill-server
