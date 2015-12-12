#!/usr/bin/env bash
# further reading: http://www.tldp.org/LDP/abs/html/exit-status.html
# http://stackoverflow.com/questions/90418/exit-shell-script-based-on-process-exit-code


# for testing
# echo fall through
# tmux kill-server
# exit

function say() {
	echo "$@"
	curl --silent --request POST --data "message=$@" http://172.17.42.1:9999/say
}

while true
do
	while true
	do
	  CLIENTS=$(tmux lsc | grep -E 'prowl')
	  STUDENT_ID=${CLIENTS%:*}

	  echo clients: $CLIENTS
	  echo student tty: $STUDENT_ID

	  if [[ ! -z $STUDENT_ID ]]; then
	      break;
	  fi

	  echo No connections found, sleeping for 5 seconds...
	  sleep 5
	done

	date
	tmux send-keys -t prowl C-u
	tmux send-keys -t prowl 'reset' C-m
	tmux send-keys -t prowl 'clear' C-m
	# echo say hi
	# tmux send-keys -t prowl 'Hi my name is Professor Owl, I am going to teach you how to Docker!'
	say 'Hi my name is Professor Owl, I am going to teach you how to Docker!'
	sleep 10
	#tmux send-keys -t prowl C-u

	#tmux send-keys -t prowl "Let's run the hello-world image"
	say "Let's run the hello-world image"
	sleep 10
	#tmux send-keys -t prowl C-u

	echo run hello-world image
	tmux send-keys -t prowl "docker run -it --rm hello-world" C-m
	sleep 10

	#echo say that was easy, wasnt it?
	#tmux send-keys -t prowl "That was easy, wasn't it?"
	say "That was easy, wasn't it?"
	sleep 10
	#tmux send-keys -t prowl C-u

	#tmux send-keys -t prowl "Well done, this concludes our lesson."
	say 'Be sure to come back and check on the progress of Professor Owl!'
	sleep 30


	say 'Ah so you are one of those people who stays to watch all the movie credits?'
	sleep 5
	say 'Enjoy :)'
	sleep 5

	
	tmux send-keys -t prowl "docker rm -f nc" C-m
	tmux send-keys -t prowl "docker run -it --name nc supertest2014/nyan" C-m
	sleep 30
	tmux send-keys -t prowl C-c

	# this will kill gotty off
	#tmux kill-server

	echo about to sleep for 15 seconds, ctrl c would be a good idea now
	sleep 15
	echo restarting
done
