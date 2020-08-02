FROM node:slim

RUN apt update && \
    apt install -y curl && \
    echo "Installing tools" && \
    npm install -g newman newman-reporter-htmlextra newman-reporter-html
