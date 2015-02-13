#!/bin/bash 

cd ~

cd /var/www/capstone/current

RAILS_ENV=production bundle exec rake scraper:get_data

