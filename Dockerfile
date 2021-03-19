# The FROM instruction sets the Base Image for subsequent instructions.
# As such, a valid Dockerfile must have FROM as its first instruction.
FROM richarvey/nginx-php-fpm:1.10.3

# The MAINTAINER instruction allows you to set the Author field of the generated images.
LABEL maintainer="Au Truong Ngoc <autk08@gmail.com>"

WORKDIR /var/www/app
ENV WEBROOT /var/www/app

RUN docker-php-ext-configure pcntl \
    && docker-php-ext-install pcntl bcmath sockets tokenizer \
    && docker-php-ext-enable xdebug

RUN apk --update add python3 \
    curl \
    nodejs \
    nodejs-npm

RUN node -v \
    npm -v

RUN npm install -g yarn

RUN rm -r /etc/nginx/sites-enabled/*
COPY ssl/october.dev /etc/nginx/sites-enabled/october.dev
COPY ssl/certs/october.dev.key /etc/ssl/private/october.dev.key
COPY ssl/certs/STAR.october.dev.crt /etc/ssl/certs/october.dev.crt
COPY ssl/certs/dhparam.pem /etc/nginx/dhparam.pem
