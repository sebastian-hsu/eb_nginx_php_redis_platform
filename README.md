# Hosting WordPress on Elastic Beanstalk Reference from Delicious Brain

This is referenced from [this post](https://deliciousbrains.com/hosting-wordpress-2017-update/) in order to create a good performance environment.

## Environment build by this repo

### Ubuntu
-  Ubuntu 16.04: depends on where your region is, change **region** and **source_ami** in [wp_eb_nginx_customize.json](wp_eb_nginx_customize.json)

| Zone           | ID           |
|---|---|
| sa-east-1      | ami-983d5ef4 |
| eu-west-1      | ami-cf3708a9 |
| ap-south-1     | ami-aa6714c5 |
| us-east-2      | ami-f2e8cc97 |
| us-west-2      | ami-817eeae1 |
| us-east-1      | ami-5def554b |
| ca-central-1   | ami-730bb617 |
| eu-central-1   | ami-02a1716d |
| ap-southeast-1 | ami-211ea242 |
| ap-southeast-2 | ami-40353a23 |
| ap-northeast-1 | ami-95d5f0f2 |
| ap-northeast-2 | ami-8572a1eb |
| eu-west-2      | ami-0d6f7b69 |
| us-west-1      | ami-08e2b968 |

### Nginx Settings
- Use [mainline version](https://deliciousbrains.com/hosting-wordpress-yourself-nginx-php-mysql/)
- [Difference between 2 branches](https://www.nginx.com/blog/nginx-1-6-1-7-released/)
- Use [FastCGI caching](https://deliciousbrains.com/hosting-wordpress-yourself-server-monitoring-caching/#page-cache)

### MariaDB

## Software Requirement
- [EB CLI 3.10.0 or later](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html)
- [Packer](https://www.packer.io/)

## steps

### change wp_eb_nginx_customize.json

### EB command
```
eb platform init
eb platform create
```

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
- [Ubuntu on AWS gets serious performance boost with AWS-tuned kernel](https://insights.ubuntu.com/2017/04/05/ubuntu-on-aws-gets-serious-performance-boost-with-aws-tuned-kernel/)

```json
{
    "Images": [
        {
            "VirtualizationType": "hvm",
            "Name": "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20170329",
            "Hypervisor": "xen",
            "EnaSupport": true,
            "SriovNetSupport": "simple",
            "ImageId": "ami-211ea242",
            "State": "available",
            "BlockDeviceMappings": [
                {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                        "DeleteOnTermination": true,
                        "SnapshotId": "snap-01fe28f553bfdf538",
                        "VolumeSize": 8,
                        "VolumeType": "gp2",
                        "Encrypted": false
                    }
                },
                {
                    "DeviceName": "/dev/sdb",
                    "VirtualName": "ephemeral0"
                },
                {
                    "DeviceName": "/dev/sdc",
                    "VirtualName": "ephemeral1"
                }
            ],
            "Architecture": "x86_64",
            "ImageLocation": "099720109477/ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20170329",
            "RootDeviceType": "ebs",
            "OwnerId": "099720109477",
            "RootDeviceName": "/dev/sda1",
            "CreationDate": "2017-03-30T18:33:52.000Z",
            "Public": true,
            "ImageType": "machine",
            "Description": "Canonical, Ubuntu, 16.04 LTS, amd64 xenial image build on 2017-03-29"
        }
    ]
}
```

- [Using Locust on AWS Elastic Beanstalk for Distributed Load Generation and Testing](https://aws.amazon.com/blogs/devops/using-locust-on-aws-elastic-beanstalk-for-distributed-load-generation-and-testing/)
- [AWS Elastic Beanstalk Load Generator Example](https://github.com/awslabs/eb-locustio-sample)