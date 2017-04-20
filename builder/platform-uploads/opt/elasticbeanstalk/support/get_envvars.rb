#!/usr/bin/env ruby

require 'json'

def get_env_vars
    env_vars = JSON.parse(`/opt/elasticbeanstalk/bin/get-config environment`)

    env_vars['PHP_DATE_TIMEZONE'] = 'UTC';

    return env_vars
end
