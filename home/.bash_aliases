#!/usr/bin/env sh
source /home/pilar/.homesick/repos/homeshick/homeshick.sh
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

alias docker-cleanc="docker ps -a -q | xargs docker rm -f"
alias docker-cleani="docker images -q | xargs docker rmi"
alias docker-cleanup="docker-cleanc; docker-cleani"

alias docker-reg-gitlab-login="docker login -u gitlab-ci-token -p $ACCESS_TOKEN  registry.gitlab.com"

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
