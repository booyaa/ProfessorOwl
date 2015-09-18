#!/usr/bin/env bash

STUDENT_ID=/dev/pts/7
while true
do
  clear
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

  echo User exit code: $?
  tmux switch-client -c $STUDENT_ID -r
  tmux send-keys C-u
  tmux send-keys "Well done, this concludes our lesson. DEBUG: lock on"
  sleep 5
  tmux send-keys C-u
done
