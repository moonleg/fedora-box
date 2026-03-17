FROM quay.io/fedora/fedora:43

LABEL project="fedora-box" \
      os="fedora" \
      type="testing" \
      maintainer="yourname@example.com" \
      version="1.0"

RUN dnf update -y && \
    dnf install -y \
    sudo \
    shadow-utils \
    curl \
    wget2 \
    tree \
    git \
    zsh \
    vim \
    gzip \
    && dnf clean all

RUN useradd -m -u 1000 -s /bin/zsh batman && \
    echo "batman ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/batman && \
    chmod 0440 /etc/sudoers.d/batman

RUN rm -f /home/batman/.zshrc

COPY --chown=root:root vimrc /root/.vimrc
COPY --chown=batman:batman vimrc /home/batman/.vimrc
COPY --chown=batman:batman zshrc /home/batman/.zshrc

RUN mkdir -p /home/batman/data && \
    chown -R 1000:1000 /home/batman/data && \
    chmod 755 /home/batman/data

USER batman

ENTRYPOINT ["/bin/zsh"]

CMD ["-l"]
# CMD ["sleep", "infinity"]
