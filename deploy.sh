#!/bin/bash

# Go to wherever your project is located
# cd /
git fetch origin

if [ `git rev-list HEAD...origin/master --count` != 0 ]; then
  git merge origin/master

  # Take her down
  php artisan down

  # Dependencies
  composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader
  yarn install

  # Clear cache and rebuild if necessary
  php artisan cache:clear

  # Speaks for itself
  php artisan migrate --force

  # Compile assets
  yarn run prod

  # Bring her back up
  php artisan up
fi
