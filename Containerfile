FROM quay.io/fedora/fedora:43

LABEL project="fedora-box"
LABEL os="fedora"
LABEL type="testing"
LABEL maintainer="yourname@example.com"
LABEL version="1.0"

RUN dnf update -y && \
    dnf autoremove -y

RUN dnf install -y \
    sudo \
    useradd \
    curl \
    wget2 \
    tree \
    git \
    zsh \
    vim \
#    unzip \
    gzip \
#    openssh \
#    cc \
    && dnf clean all

COPY vimrc /root/.vimrc

RUN useradd -m -u 1000 -s /bin/zsh batman && \
    echo "batman ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/batman && \
    chmod 0440 /etc/sudoers.d/batman

RUN rm -f /home/batman/.zshrc

COPY --chown=batman:batman vimrc /home/batman/.vimrc
COPY --chown=batman:batman zshrc /home/batman/.zshrc

RUN mkdir -p /home/batman/data && \
    chown -R 1000:1000 /home/batman/data && \
    chmod 755 /home/batman/data

USER batman

CMD ["sleep", "infinity"]
