FROM ubuntu:22.04
RUN apt update
RUN apt install -y curl 
RUN curl -L https://omnitruck.cinc.sh/install.sh | bash -s -- -P cinc-server -v 14

