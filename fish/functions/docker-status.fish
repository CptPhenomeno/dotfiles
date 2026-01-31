function docker-status --wraps='sudo systemctl status containerd docker.socket docker' --description 'alias docker-status=sudo systemctl status containerd docker.socket docker'
    sudo systemctl status containerd docker.socket docker $argv
end
