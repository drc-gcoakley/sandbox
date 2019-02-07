#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
alias cde=cd
alias cp='cp -p'

# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
alias 7z='/c/Progra~1/7-Zip/7z'
alias choc-installed="choco list --local-only | sort" # or: cinst -l | sort
alias choc-upgrade='choco upgrade chocolatey'
# curlg ~= 'curl --insecure --location --include --silent --show-error'
alias curlg='curl --kLisS'
alias ct='clear; date;'
alias diff='diff -b'
alias ee='vi /c/dev/config/gac_env.sh'
alias findf='find . -type f'
alias findd='find . -type d'
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
alias hg='history | grep'
alias less='less -eF'
# Don't set the LESS environment variable as it causes git output to mishandle the terminal. 
alias more=less
alias m=more
alias mroe=more
alias rfp='reset-windows-file-perms'
alias shell-options='set -o'
alias show-shell-options='set -o'
alias tty-reset='reset'
alias which='type -a'                         # where, of a sort
alias whence='type -a'                        # where, of a sort
#
# Some shortcuts for different directory listings
# source ~/scripts/ls-colors.sh
alias lrt='ls -lrt'
alias lt='ls -lt'
alias ls='ls -Ch --file-type --color=no'                 # classify files in colour
alias dir='ls --color=no --format=vertical'
# alias vdir='ls --color=no --format=long'
alias la='ls -A'                    # all but . and ..
alias ll='ls -l'                    # long list
alias lla='ls -lA'                  # long list of all but . and ..
alias lld='ls -lad'                 # long list as directories--don't show directory contents.
function mcd() { mkdir -p $@; cd $@; }
alias npp='/c/dev/bin/Notepad++/notepad++.exe'
alias scp='scp -i ~/.ssh/drc_id_rsa'
alias sftp='sftp -i ~/.ssh/drc_id_rsa'
alias ssh='ssh -i ~/.ssh/drc_id_rsa'

PATH=$(~/scripts/path-remove '/windows/System32' 'SQL Server/')
export PATH=~/scripts/drc:~/scripts:~/bin:/c/dev/bin/grails-2.4.5/bin:/c/dev/bin/mongo-3.2.11/bin:/c/dev/bin/dockerToolbox:${PATH}

PATH="${PATH}:/c/home/gcoakley/perl5/bin"; export PATH;
PERL5LIB="/c/home/gcoakley/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/c/home/gcoakley/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/c/home/gcoakley/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/c/home/gcoakley/perl5"; export PERL_MM_OPT;

function winmerge() { /c/Progra~2/tools/WinMerge/WinMergeU.exe $@ & }


# General development
#
function goto_pkg_json() { 
  [ ! -r package.json ] && [ -r app/package.json ] && cd app; 
  [ ! -r package.json ] && [ $(basename $PWD) = "app" ] && cd ..; 
}

source ${GAC_CFG_DIR}/git-completion.bash
source ${GAC_CFG_DIR}/dflt_completion_handler_for_npx.bash
source ${GAC_CFG_DIR}/my-git-prompt.bash
# my-git-prompt replaces: source ${GAC_CFG_DIR}/bash-git-prompt.bash
source ${GAC_CFG_DIR}/ssh-agent-start.sh

alias grails='grails --stacktrace'
alias grails245='/c/dev/bin/grails-2.4.5/bin/grails --stacktrace'
alias grails256='/c/dev/bin/grails-2.5.6/bin/grails --stacktrace'
alias npmo='npm --prefer-offline'
alias nitbi='goto_pkg_json; [ -r package.json ] && npmo install && npmo install-test && bower install'
alias nubu='goto_pkg_json; [ -r package.json ] && npm update && bower update'
#alias npitubpiu='npm prune && npmo install && npmo install-test &&^ npm update && bower prune && bower install && bower update'
alias npmgls='ls $NPM_GCACHE/node_modules/'
function npml() { npmo --registry http://127.0.0.1:2222 $@; }
# npm's "--cache-min Infinity" has been deprecated for "--prefer-offline".
alias nrd='npmo run dev'
# https://docs.npmjs.com/misc/config
alias ni='goto_pkg_json; [ -r package.json ] && npmo install'
function win() { /c/windows/system32/$@ ; }

export VAGRANT_HOME=c:/dev/runtime/vagrant


# DRC development
#
# Setting BROWSER stops Karma from complaining:
#    browser_gpu_channel_host_factory.cc(121)] Failed to launch GPU process.
export BROWSER=google-chrome
export NPM_GCACHE="/c/dev/runtime/npm_global_cache"
export WKSP=/c/dev/wksp
export ECA=$WKSP/eca
function wksp() { cd $WKSP; [ -n "$1" ] && [ -d $1 ] && cd $1 && goto_pkg_json; }
alias ws='wksp'
function eca() { cd $ECA; [ -n "$1" ] && [ -d $1 ] && cd $1 && goto_pkg_json; }
function ets() { cd $ECA/typescript; [ -n "$1" ] && [ -d $1 ] && cd $1 && goto_pkg_json; }

alias diff="\diff -x package-lock.json -x node_modules"
alias ei='cd $eca/typescript/eca-ideas-portal-ui'
alias it='iat-test'
alias codenarc='grails --offline codenarc'
alias grailssh='grails --offline shell'
alias groovysh='/c/dev/bin/groovy-sdk-2.3.3/bin/groovysh'
alias nc='/c/dev/runtime/npm_caching/npm_lazy/start-auto-caching.sh &'
alias ngs='ng serve -v --port 4321'
function npri() { npm uni $@; npm cache clean; npm i $@; }
function yari() { yarn remove $@; yarn cache clean $@; yarn add $@; }
alias yarn='yarn --prefer-offline'

export iatapp="$WKSP/iat/iatapp"		; alias iatapp="cd $iatapp$@"
export iat_spare="$WKSP/iat-spare/iatapp"	; alias iat-spare="cd $iat_spare$@"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/c/home/gcoakley/.sdkman"
#[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
#alias sdkman=sdk


alias alecl="cd /c/dev/wksp/eca/typescript/nrwl_projects/angular_library_module_ex/eca-client-lib"
alias nwecl="cd /c/dev/wksp/eca/typescript/nrwl_projects/eca-portal-v2-ui"
