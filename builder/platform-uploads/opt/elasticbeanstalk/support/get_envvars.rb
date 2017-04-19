#!/bin/env ruby

require 'json'

def get_env_vars
    env_vars = JSON.parse(`/opt/elasticbeanstalk/bin/get-config environment`)
    php_env_vars = JSON.parse(`/opt/elasticbeanstalk/bin/get-config optionsettings -n "aws:elasticbeanstalk:container:php:phpini"`)
    
    php_env_vars.each { |key, value| env_vars['PHP_' + key.upcase] = value }
    
    env_vars['PHP_DATE_TIMEZONE'] = 'UTC';

    return env_vars
end
