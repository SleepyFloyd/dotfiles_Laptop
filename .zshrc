########################
#      zshrc file      # 
########################

PS1="[%m] %4c %(!.#.$) "
prompt elite
## If not running interactively, do nothing 
[ -z "$PS1" ] && return

## load zsh modules
autoload -U compinit promptinit zsh-mime-setup
compinit
promptinit
#zsh-mime-setup

## Options
setopt printexitvalue          # alert me if something's failed
setopt GLOB_COMPLETE
setopt PUSHD_MINUS
setopt RM_STAR_WAIT		# waits 10 seconds before deleting
setopt ZLE
setopt NO_HUP
setopt VI
setopt NO_BEEP
setopt NO_CASE_GLOB
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB
setopt IGNORE_EOF
setopt MENUCOMPLETE
setopt ALL_EXPORT

setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes mailwarning

unsetopt bgnice autoparamslash
unsetopt ALL_EXPORT

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

## Variables
PATH="/usr/local/bin:/usr/local/sbin/:/bin:/sbin:/usr/bin:/usr/sbin:$PATH"
manpath=(/usr/local/share/man:/usr/share/man $manpath)
TZ="Europe/Berlin"
HOSTNAME="`hostname`"
PAGER='less'
EDITOR='vim'
LC_ALL='de_DE.UTF-8'
LANG='de_DE.UTF-8'
LC_CTYPE=C

## Color completion
## this module should be automatically loaded if u use menu selection
## but to be sure we do it here
zmodload -i zsh/complist
ZLS_COLORS=$LS_COLORS

## Keys
bindkey '\e[A'  up-line-or-history
bindkey '\e[B'  down-line-or-history
bindkey '\e[C'  forward-char
bindkey '\e[D'  backward-char
bindkey '\eOA'  up-line-or-history
bindkey '\eOB'  down-line-or-history
bindkey '\eOC'  forward-char
bindkey '\eOD'  backward-char

bindkey "^?" backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

###################
##    ALIASES    ##
###################

# Directory navigation aliases
alias '..'='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'


# Suffix Aliases
alias -s png=feh
alias -s jpg=feh
alias -s jpeg=feh
alias -s html=w3m
alias -s org=w3m
alias -s de=w3m
alias -s com=w3m
alias -s netw3m
alias -s mpeg=mplayer
alias -s mp3=mplayer
alias -s mpg=mpayer
alias -s avi=mplayer
alias -s tex=gvim

alias -g G="| grep"
alias -g L="| less"
alias df='df -h'
alias du='du -h -c'

alias ll='ls -lah'
alias lr='ls -lahr'
alias lx='ll -BX'
alias lss='ll -rS'
alias lt='ll -rt'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -h now'
alias suspend='sudo pm-suspend'
alias update='sudo clyde -Syu --aur'
alias news='newsbeuter -r'
alias ping='ping -c 3'
alias scrot='scrot -q 80'
alias server='ssh 192.168.1.102'
alias stuff='sudo mount 192.168.1.102:/home/sleepy /home/sleepy/mount'

# Date and time
alias date="remind '-kecho Today is %s' &&
date '+%A, %e %B %Y * %H:%M'"

# Package manager
alias rm='rm -vi'
alias copy='cp -f'
#alias cp='cp -vi'
alias mv='mv -vi'

mdc() { mkdir -p "$1" && cd "$1" }

# Extract archives
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

alias nc='ncmpcpp'

# Console fonts
alias terminus14='consolechars -f Lat2-Terminus14.psf'
alias terminus16='consolechars -f Lat2-Terminus16.psf'
alias fixed14='consolechars -f Lat2-Fixed14.psf'
alias fixed13='consolechars -f Lat15-Fixed13.psf'
alias fixed16='consolechars -f Lat2-Fixed16.psf'
alias alt14='consolechars -f alt-8x14.psf'	

###################
##    HISTORY    ##
###################

HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000

setopt EXTENDED_HISTORY		# puts timestamps in the history

setopt HIST_VERIFY		# when using ! cmds, confirm first
setopt HIST_IGNORE_DUPS		# ignore same commands run twice+
setopt APPEND_HISTORY		# don't overwrite history 
setopt SHARE_HISTORY		# _all_ zsh sessions share the same history files
#setopt hist_ignore_space       # ignore commands that have a leading space
setopt INC_APPEND_HISTORY	# write after each command

# Search history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end


######################
##    COMPLETION    ##
######################

setopt CORRECT			# command CORRECTION

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Fuzzy matching of completions for when you mistype them
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Prevent CVS files/directories from being completed
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command' 

zstyle ':completion:*:*:killall:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:killall:*:processes' command 'ps --forest -A -o pid,user,cmd'

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'


zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate

zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
#zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

################################################################
