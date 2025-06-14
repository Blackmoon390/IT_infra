FROM php:8.1-apache

# Install required PHP extensions and dependencies
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    git \
    zip \
    libonig-dev \
    && docker-php-ext-install intl pdo pdo_mysql xml zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/kimai

# Copy app files (later with CI/CD you’ll clone from Git)
COPY . /var/www/kimai

# Set permissions
RUN chown -R www-data:www-data /var/www/kimai

# Health check
HEALTHCHECK CMD curl --fail http://localhost || exit 1
