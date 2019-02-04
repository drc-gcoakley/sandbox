git_dirty () {
  local modCount=$(git status --porcelain 2> /dev/null | wc -l)
  if [ "$modCount" -gt 0 ]; then
    git_dirty=' *'
  else
    git_dirty=''
  fi
}

git_branch () {
  git_branch=""

  #if [ "$(git rev-parse --is-inside-work-tree)" = "true" ]; then
  if [[ $PWD =~ /c/dev/wksp/ ]]; then

    # Based on: https://github.com/jimeh/git-aware-prompt/blob/master/prompt.sh
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [ $? ]; then
      if [ "$branch" == "HEAD" ]; then
        branch='detached'
      fi
      git_dirty
      git_branch="(${branch}${git_dirty}) "
    fi
  fi
}

time_now () {
  time_now=$(date +'%H:%M.%S')
}

truncate_path () { 
  maxlen=${1:-70}
  cutoff=$(($maxlen - 3))
  truncate_path=$(pwd | perl -e '{ $_=<>; $l=length($_); printf("%s%s\n", $l>'$cutoff' ? "...": "", substr($_,0, $l<'$maxlen' ? $l: '$maxlen'));}' )
  # Below is faster but does not handle paths containing spaces. 
  # truncate_path=$(pwd | awk '{printf("%s%s\n", length($1)>'$cutoff' ? "...": "", substr($1, length($1)-'$maxlen'));}')
}

### This is SLOW.
#if [[ ! $PROMPT_COMMAND =~ git_branch ]]; then export PROMPT_COMMAND="git_branch; time_now; truncate_path 90; $PROMPT_COMMAND"; fi
if [[ ! $PROMPT_COMMAND =~ truncate_path ]]; then export PROMPT_COMMAND="time_now; truncate_path 90; $PROMPT_COMMAND"; fi

# Default Git enabled prompt with dirty state
#export PS1="\[\033[0;36m\]\${time_now} \[\033[0;0m\]\${git_branch}\[\033[0;32m\]\${truncate_path}\[\033[0;0m\]\n\$ "
export PS1="\[\033[0;36m\]\${time_now} \[\033[0;0m\]\[\033[0;32m\]\${truncate_path}\[\033[0;0m\]\n\$ "
