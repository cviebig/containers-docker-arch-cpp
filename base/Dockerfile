FROM archlinux/base

RUN curl -o /etc/pacman.d/mirrorlist "https://www.archlinux.org/mirrorlist/?country=DE&use_mirror_status=on" && \
    sed -i 's/^#//' /etc/pacman.d/mirrorlist && \
    pacman -Sy --noprogressbar --noconfirm --needed \
        sudo \
        && \
    pacman -Scc --noconfirm && \
    rm -rf /usr/share/man/* && \
    useradd --create-home --shell /bin/bash user && \
    echo "user   ALL=(ALL) ALL" >> /etc/sudoers && \
    echo "Defaults:user      !authenticate" >> /etc/sudoers

USER user
WORKDIR /home/user
