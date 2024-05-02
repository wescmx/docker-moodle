# Build args
ARG PHP_VERSION

# Get the image version from the build args
FROM php:${PHP_VERSION}-alpine

# Install php extensions
RUN docker-php-ext-install pdo pdo_mysql

# Set the working directory
WORKDIR /var/www/html
