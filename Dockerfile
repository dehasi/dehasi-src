FROM jekyll/builder:4

RUN apk update && apk upgrade && \
    apk add --no-cache fontconfig ttf-dejavu

RUN mkdir /graphviz && \
  apk add --update graphviz

# docker build . -t dehasi/jekyll:4
