FROM hashicorp/packer:latest

RUN apk add --no-cache \
    python3 \
    py3-pip \
    openssh \
    ansible

ENTRYPOINT ["packer"]
