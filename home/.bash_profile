export PATH="$HOME/.pkenv/bin:$PATH"
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Will add to path only if:
# * The directory or file exists
# * And it is not already in the path
add-to-path () {
  if test -e "$1"; then
    if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
      if [ "$2" = "after" ] ; then
        PATH="$PATH:$1"
      else
        PATH="$1:$PATH"
      fi
    fi
  fi
}

# Update PATH
add-to-path "$HOME/.pkenv/bin:$PATH"
add-to-path "/home/pilar/Software/bin/:${PATH}"
add-to-path "${GOPATH}/bin:${PATH}"
add-to-path "/home/pilar/.npm-global/bin:${PATH}"

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
add-to-path "$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

