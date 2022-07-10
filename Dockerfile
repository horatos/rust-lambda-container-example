FROM public.ecr.aws/lambda/provided:al2 AS develop

RUN yum groupinstall "Development Tools" -y && \
    yum install -y shadow-utils

ENV PATH $PATH:/usr/sbin

ARG USERNAME=app
ARG GROUPNAME=app
ARG UID
ARG GID

RUN getent group $GID || groupadd -g $GID $GROUPNAME
RUN useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH $PATH:/home/$USERNAME/.cargo/bin


FROM public.ecr.aws/lambda/provided:al2

COPY ./target/debug/rust-lambda-container-example /var/runtime/bootstrap

CMD ["handler"]
