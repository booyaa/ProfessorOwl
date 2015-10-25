#!/usr/bin/env bash
# further reading: 
# - http://www.tldp.org/LDP/abs/html/exit-status.html
# - http://stackoverflow.com/questions/90418/exit-shell-script-based-on-process-exit-code

function say() {
        echo "$@"
	#FIXME hard coded hostname
        curl --silent --request POST --data "message=$@" http://172.17.42.1:9999/say
}

while true
do
        while true
        do
          CLIENTS=$(tmux lsc | grep -E 'prowl')
          STUDENT_ID=${CLIENTS%:*}

          # echo clients: $CLIENTS student tty: $STUDENT_ID

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
        say 'Hi my name is Professor Owl, I am going to teach you how to Docker!'
        sleep 10

        say "Let's run the hello-world image"
        sleep 10

        echo run hello-world image
        tmux send-keys -t prowl "docker run -it --rm hello-world" C-m
        sleep 10

        say "That was easy, wasn't it?"
        sleep 10

        say 'Be sure to come back and check on the progress of Professor Owl!'
        sleep 30

        say 'Ah so you are one of those people who stays to watch all the movie credits?'
        sleep 5
        say 'Enjoy :)'
        sleep 5

        tmux send-keys -t prowl "docker rm -f nc" C-m
        tmux send-keys -t prowl "docker run -it --name nc supertest2014/nyan" C-m
        sleep 30
        tmux send-keys -t prowl C-c # OOB FTW!

        echo about to sleep for 15 seconds, ctrl c would be a good idea now
        sleep 15
        echo restarting
done
