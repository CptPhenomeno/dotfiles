function docker-start --wraps='sudo systemctl start containerd docker.socket docker' --description 'alias docker-start=sudo systemctl start containerd docker.socket docker'
    sudo systemctl start containerd docker.socket docker $argv
end
