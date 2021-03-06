if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '                                                                                              
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '                                                                                                                                                    
    PS1='${debian_chroot:+($debian_chroot)}\u@\W\$ '
fi

#
# Alias settings
#
alias emacs="TERM=screen-256color emacs"

# 
# Other settings
# 
# Enable ctrl+s 
stty stop undef