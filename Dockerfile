FROM jekyll/jekyll:4 as builder

WORKDIR /src
RUN git clone https://github.com/utmapp/docs.getutm.app.git .

# donner les droits au user jekyll sur le dossier
RUN chown -R jekyll:jekyll /src

USER jekyll

RUN bundle install --path vendor/bundle && \
    bundle exec jekyll build -d /build

FROM nginx:alpine

COPY --from=builder /build /usr/share/nginx/html

EXPOSE 80
