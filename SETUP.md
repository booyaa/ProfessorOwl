# Setup and installation of Professor Owl

You'll need the following:
- docker-machine
- a digital ocean account

## Provision your docker engine

    export DO_PAT=your_digital_ocean_personal_access_token
    docker-machine create prowl \
            --driver digitalocean \
            --digitalocean-region "sfo1" \
            --digitalocean-size "1gb"

This will create a new docker-machine called prowl, which will be an ubuntu 
server with 1GB of RAM in Digital Ocean's San Francisco data centre.

## Install additional software as root

    apt-get update && apt-get install tmux curl
    mkdir /root/stage
    cd /root/stage
    curl -LO https://github.com/yudai/gotty/releases/download/v0.0.12/gotty_linux_amd64.tar.gz 
    mv gotty /usr/local/bin
    chmod a+x /usr/local/bin/gotty

We need tmux and gotty as these form the scaffolding for Professor Owl.

    git clone git@github.com:booyaa/silkcabbage
    cd silkcabbage/thereandbackagain
    # witness the power of zero go install and go 1.5
    docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp -e GOOS=linux -e GOARCH=amd64 golang:1.5 go build -v
    mv myapp /usr/local/bin/bilbo

"bilbo" is a small http server that will handle the Professor's communication (via ajax).

    git clone git@github.com:booyaa/ProfessorOwl
    cd ../ProfessorOwl

## Setup tmux (TODO automate this via tmux.conf or smidklol)

We'll setup two tmux sessions, one is used by the Professor Owl, the other is
for monitor the progress of the script and other admin duties.

    tmux new-session -d -s prowl 
    tmux new-session -s monitor 

We'll attach to the second session and create the following panes:

note: replace references to 172.17.42.1 with the ip address of docker0 in the
gotty pane and in the default.conf for nginx (before running the builder)

- pane: gotty
    - command `unset TMUX && gotty --address 172.17.42.1 --reconnect --index prowl.html tmux attach -t prowl`
- pane: nginx
    - command
          ```
          scripts/build_nginx.sh
          script/start_nginx.sh
          ```
- pane: bilbo
    - command `bilbo`
- pane: prowl
    - command `script/poc.sh`

## That's all folks

If you're very lucky you'll see a working demo on your website, alternatively
go to http://professorowl.booyaa.org you'll see a working demo.
