function connect-hpdebian --wraps="ssh -i .ssh/hpdebian_rsa 'server@hp-debian.local'" --description "alias connect-hpdebian=ssh -i .ssh/hpdebian_rsa 'server@hp-debian.local'"
    ssh -i .ssh/hpdebian_rsa 'server@hp-debian.local' $argv
end
