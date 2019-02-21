#!/usr/bin/env sh
source /home/pilar/.homesick/repos/homeshick/homeshick.sh
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

if [ -f ~/.bash_extras ]; then
    source ~/.bash_extras
fi

alias docker-cleanc="docker ps -a -q | xargs docker rm -f"
alias docker-cleani="docker images -q | xargs docker rmi"
alias docker-cleani-f="docker images -q | xargs docker rmi -f"
alias docker-cleanup="docker-cleanc; docker-cleani-f"

alias docker-reg-gitlab-login="docker login -u gitlab-ci-token -p $ACCESS_TOKEN  registry.gitlab.com"

alias git-pull-all="${HOME}/.aliases/git_pull_all.sh"

docker-id-i() {
    docker images | grep $1 | awk '{print $3}'
}
docker-id-c() {
    docker ps -a | grep $1 | awk '{print $1}'
}

docker-rm-i() {
    docker rmi $(docker-id-i $1)
}

docker-rm-c() {
    docker rm -f $(docker-id-c $1)
}

docker-bash() {
    docker exec -it $(docker-id-c $1) /bin/bash
}

export GOPATH="${HOME}/go"

# Source senstive env vars
if [ -f ~/.bash_vars ]; then
    . ~/.bash_vars
fi

source ~/.bash_work/.hmrc
