ARG  BASE_IMAGE=archlinux/base
FROM ${BASE_IMAGE}

RUN sudo pacman -S --noprogressbar --noconfirm --needed \
        base-devel \
        boost \
        catch2 \
        clang \
        cmake \
        gcc \
        gdb \
        git \
        llvm \
        ninja \
        valgrind \
        && \
    sudo pacman -Scc --noconfirm && \
    sudo rm -rf /usr/share/man/*

USER user
VOLUME /home/user/project
VOLUME /home/user/build
VOLUME /tmp
