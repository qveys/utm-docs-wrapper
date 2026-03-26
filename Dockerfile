FROM jekyll/jekyll:4 as builder

WORKDIR /src
RUN git clone https://github.com/utmapp/docs.getutm.app.git .

# Configurer bundler pour écrire dans un dossier local
RUN bundle config set --local path 'vendor/bundle'

RUN bundle install && \
    bundle exec jekyll build -d /build

FROM nginx:alpine

COPY --from=builder /build /usr/share/nginx/html

EXPOSE 80
