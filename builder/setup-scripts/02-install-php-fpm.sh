#   Copyright 2016-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
#   Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the License. A copy of the License is located at
#
#   http://aws.amazon.com/apache2.0/
#
#   or in the "license" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

#!/bin/bash -xe

. $BUILDER_DIR/CONFIG

add-apt-repository ppa:ondrej/php -y
apt-get update
apt-get install php7.1-fpm php7.1-common php7.1-mysqlnd php7.1-xmlrpc php7.1-curl php7.1-gd php7.1-imagick php7.1-cli php-pear php7.1-dev php7.1-imap php7.1-mcrypt -y

# upload php.ini later since system will be halt while there's php.ini existed during php installation
rsync -ar $BUILDER_DIR/platform-uploads-2nd/etc/php/7.1/fpm/ /etc/php/7.1/fpm/
service php7.1-fpm restart
