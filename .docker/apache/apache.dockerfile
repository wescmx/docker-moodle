# Build args
ARG PHP_VERSION

# Get the image version from the build args
FROM php:${PHP_VERSION}-apache

# Install dependencies
RUN apt update && apt-get install -y graphviz aspell ghostscript clamav unzip curl libicu-dev libxml2-dev libldap2-dev libssl-dev libzip-dev libcurl4-openssl-dev libonig-dev libpng-dev libjpeg-dev libfreetype6-dev && rm -rf /var/lib/apt/lists/*

# Enable apache modules
RUN a2enmod rewrite headers

# Install php extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-configure exif --enable-exif \
    && docker-php-ext-install -j$(nproc) curl intl mysqli xml ldap zip soap opcache exif gd

# Use pecl to get Redis extension ready
RUN pecl install redis \
    # Redis is installed, enable it
    && docker-php-ext-enable redis

# Create the moodledata directory
RUN mkdir -p /mnt/moodledata/moodle \
    && chown -R www-data:www-data /mnt/moodledata/moodle \
    && chmod -R 777 /mnt/moodledata/moodle

# Add the vhost file
ADD ./sites-available/000-default.conf /etc/apache2/sites-available/

# Set the working directory
WORKDIR /var/www/html
