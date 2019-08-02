ARG  BASE_IMAGE=archlinux/base
FROM ${BASE_IMAGE}

RUN sudo pacman -S --noprogressbar --noconfirm --needed \
        boost-libs \
        && \
    sudo pacman -Scc --noconfirm && \
    sudo rm -rf /usr/share/man/*

VOLUME /home/user/project
VOLUME /home/user/build
VOLUME /tmp
