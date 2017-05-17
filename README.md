# Hosting WordPress on Elastic Beanstalk using Ubuntu/PHP/Nginx

This is referenced from [Delicious Brain post](https://deliciousbrains.com/hosting-wordpress-2017-update/) in order to create a good performance WordPress environment.

## Howto

### Config wp_eb_nginx_customize.json **builders** section
- region: your aws region
- source_ami: check [Ubuntu](#Ubuntu) section to choose your AMI 

### EB command
```
eb platform init
eb platform create
```

## Environment build by this repo

### Ubuntu<a name="Ubuntu"></a>
- Ubuntu 16.04: depends on where your region is, change **region** and **source_ami** in [wp_eb_nginx_customize.json](wp_eb_nginx_customize.json)
- **Please use the AMI release BEFORE 2017/03/29** due to Ubuntu issue (I have issued a ticket and this is what support said)
- You can go to [https://cloud-images.ubuntu.com/locator/](https://cloud-images.ubuntu.com/locator/) to find the latest AMI in your region by using following filters

|Filter|Value|
|:---:|:---:|
|Cloud|Amazon AWS|
|Zone|[choose your region]|
|Name|xenial|
|Version|16.04|
|Arch|amd64|
|Instance Type|hvm-ssd|
|Release|[choose the one before 20170329]|

### Nginx Settings
- Use [mainline version](https://deliciousbrains.com/hosting-wordpress-yourself-nginx-php-mysql/)
- [Difference between 2 branches](https://www.nginx.com/blog/nginx-1-6-1-7-released/)
- Use [FastCGI caching](https://deliciousbrains.com/hosting-wordpress-yourself-server-monitoring-caching/#page-cache)

### MariaDB

## Software Requirement
- [EB CLI 3.10.0 or later](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html)
- [Packer](https://www.packer.io/)

## Packer builders with debugging on Windows under PowerShell
```
$env:PACKER_LOG=1
$env:PACKER_LOG_PATH="packerlog.txt"
packer build wp_eb_nginx_customize.json
```

## HTTP2 supported

## You should install the following plugins to get boost of this nginx settings
- [Redis Object Cache](https://wordpress.org/plugins/redis-cache/)
- [Amazon Web Service](https://wordpress.org/plugins/amazon-web-services/)
- [WP Offload S3 Lite](https://wordpress.org/plugins/amazon-s3-and-cloudfront/)

## todo
- vi /etc/php/7.1/fpm/php-fpm.conf
- http2 alb
- setup cloudwatch logs
- http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/customize-environment-resources-elasticache.html

##
- If you are cloning this project and you are using Windows, remember to set `git config --global core.autocrlf input` 

## ref
- [Launch: AWS Elastic Beanstalk launches support for Custom Platforms](https://aws.amazon.com/cn/blogs/aws/launch-aws-elastic-beanstalk-launches-support-for-custom-platforms/)
- [Using Locust on AWS Elastic Beanstalk for Distributed Load Generation and Testing](https://aws.amazon.com/blogs/devops/using-locust-on-aws-elastic-beanstalk-for-distributed-load-generation-and-testing/)
- [AWS Elastic Beanstalk Load Generator Example](https://github.com/awslabs/eb-locustio-sample)