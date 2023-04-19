FROM ubuntu:20.04
          
RUN apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install locales tzdata openssl ca-certificates -y \
    && /usr/sbin/update-ca-certificates \
    && locale-gen en_US.UTF-8 pt_BR.UTF-8
          
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive
ENV SECRET=***REMOVED***

# rootless
RUN useradd --create-home --uid 1000 gopher
WORKDIR /home/gopher
USER 1000
          
COPY ./binaries ./

CMD ["./evil-go-app-bin"]

