FROM ruby:3.1 as builder

RUN apt-get update && apt-get install -y git build-essential libxml2-dev libxslt1-dev nodejs && rm -rf /var/lib/apt/lists/*

WORKDIR /src
RUN git clone https://github.com/utmapp/docs.getutm.app.git .

# Installer bundler et les gems dans un dossier local
RUN gem install bundler -v 2.3.22
RUN bundle _2.3.22_ config set --local path 'vendor/bundle'
RUN bundle _2.3.22_ install
RUN bundle _2.3.22_ exec jekyll build -d /build

FROM nginx:alpine

COPY --from=builder /build /usr/share/nginx/html

EXPOSE 80
