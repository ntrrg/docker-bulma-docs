FROM jekyll/jekyll as jekyll
ARG BULMA_VERSION="0.9.2"
WORKDIR /tmp
RUN \
  apk add --no-cache git && \
  git clone --depth 1 -b "$BULMA_VERSION" "https://github.com/jgthms/bulma.git" && \
  chown -R jekyll:jekyll "bulma"
RUN \
  cd "bulma/docs" && \
  sed -i "s/https:\/\/bulma.io/\//" "_config.yml" && \
  jekyll build --incremental

FROM ntrrg/nginx:http
COPY --from=jekyll /tmp/bulma/docs/_site /usr/share/nginx/html

