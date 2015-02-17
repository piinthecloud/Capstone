#!/bin/bash

cd ~

cd /var/www/capstone/current

RAILS_ENV=production rake scraper:get_data
