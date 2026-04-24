FROM quay.io/fedora/fedora:latest

LABEL project="toolbox" \
      os="fedora" \
      type="testing" \
      maintainer="yourname@example.com" \
      version="1.2"

RUN dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    && dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    && dnf update -y \
    && dnf install -y \
    sudo \
    shadow-utils \
    curl \
    wget2 \
    tree \
    git \
    zsh \
    vim \
    tar \
    gzip \
    python3-pip \
    && dnf -y clean all

ARG USERNAME=batman
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN useradd -m -u $USER_UID -s /bin/zsh $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

COPY --chown=root:root vimrc /root/.vimrc

# Change to user
USER $USERNAME
WORKDIR /home/$USERNAME

COPY --chown=$USERNAME:$USERNAME vimrc /home/$USERNAME/.vimrc
COPY --chown=$USERNAME:$USERNAME zshrc /home/$USERNAME/.zshrc

RUN mkdir -p /home/$USERNAME/shared /home/$USERNAME/.ssh && \
    chmod 755 /home/$USERNAME/shared && \
    chmod 0700 /home/$USERNAME/.ssh

ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"

# For Ansible
# ENV ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python3
# RUN pip install --user --no-cache-dir ansible-core ansible-lint

ENTRYPOINT ["/bin/zsh", "-c", "sleep infinity"]
CMD ["-l"]
