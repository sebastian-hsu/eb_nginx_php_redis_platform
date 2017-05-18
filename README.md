# Hosting WordPress on Elastic Beanstalk using Ubuntu/PHP/Nginx

This is referenced from [Delicious Brain post](https://deliciousbrains.com/hosting-wordpress-2017-update/) in order to create a good performance WordPress environment. 
This project is revised from [AWS Sample NodePlatform_Ubuntu.zip](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/custom-platforms.html#custom-platforms-sample), I am not a Ubuntu/Nginx expert, any feedback will be very appreciated.

## Howto

### Install Elastic Beanstalk CLI
- [Install the Elastic Beanstalk Command Line Interface (EB CLI)](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html)

### Config wp_eb_nginx_customize.json **builders** section
- region: input your aws region
- source_ami: check [Ubuntu](#Ubuntu) section to choose your AMI 
- instance_type: input the type you need
- ami_name: specify your AMI name

### Create Elastic Beanstalk Custom Platform
- In your project folder, execute the following
```
eb platform init
eb platform create
```
- More information can ref to [Launch: AWS Elastic Beanstalk launches support for Custom Platforms](https://aws.amazon.com/blogs/aws/launch-aws-elastic-beanstalk-launches-support-for-custom-platforms/)

### Create Elastic Beanstalk WordPress Application
- 
https://cloud.githubusercontent.com/assets/6972644/26134175/4debf3ac-3adf-11e7-9499-5a080cf5cad6.png
- The ability to create an environment with an already created custom platform is only available for the [new environment wizard](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environments-create-wizard.html).

## Environment build by this repo

### Ubuntu<a name="Ubuntu"></a>
- Ubuntu 16.04: depends on where your region is, change **region** and **source_ami** in [wp_eb_nginx_customize.json](wp_eb_nginx_customize.json)
- **Please use the AMI release BEFORE 2017/03/29** due to Ubuntu issue,  the issue is with the kernel version "vmlinuz-4.4.0-72-generic".
Beanstalk environment builder generates a second version of "wp_eb_nginx_customize.json" configuration file named "eb-packer.json" by appending a command to run "eb-bootstrap.sh" on the base instance for the AMI. 
This "eb-bootstrap.sh" bootstraps the AMI with the Beanstalk gems, tarballs etc. 
In executing one of the command "apt-get upgrade" of eb-bootstrap.sh file, it is getting stuck and the environment is timing out. 
This is because new kernel version throws an interactive prompt while running "apt-get upgrade" to let the user decide how/if to replace the existing GRUB "menu.lst" configuration that decides the sequence/priority of available kernels to load during boot-up. 
I even put `export DEBIAN_FRONTEND=noninteractive` in shell script but it doesn't help.
So please use the AMI release before 2017/03/29 at this moment.
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
- setup cloudwatch logs
- http2 alb
- http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/customize-environment-resources-elasticache.html

##
- If you are cloning this project and you are using Windows, remember to set `git config --global core.autocrlf input` 

## ref
- [Using Locust on AWS Elastic Beanstalk for Distributed Load Generation and Testing](https://aws.amazon.com/blogs/devops/using-locust-on-aws-elastic-beanstalk-for-distributed-load-generation-and-testing/)
- [AWS Elastic Beanstalk Load Generator Example](https://github.com/awslabs/eb-locustio-sample)