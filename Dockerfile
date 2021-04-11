FROM jekyll/jekyll as jekyll
ARG BULMA_VERSION="0.9.2"
ENV NEW_URL="http:\\/\\/localhost:4321"
WORKDIR /tmp
RUN \
  apk add --no-cache git && \
  git clone --depth 1 -b "$BULMA_VERSION" "https://github.com/jgthms/bulma.git" && \
  chown -R jekyll:jekyll "bulma"
RUN \
  cd "bulma/docs" && \
  sed -ie "s/https:\/\/bulma.io/$NEW_URL/" "_config.yml" && \
  jekyll build --incremental

FROM caddy:2.3.0-alpine
COPY --from=jekyll /tmp/bulma/docs/_site /usr/share/caddy

