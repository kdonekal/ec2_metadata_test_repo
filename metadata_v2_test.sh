#!/bin/bash

# DISCLAIMER: This script only works with IMDSv2 setup type of EC2 instances.
# since late 2023 the default IMDS is changed to IMDSv2 hence we need a token before hand to query and extract the output from EC2 metadata
# Registering the needful metadata api token below
# Default AWS EC2 metadata end-point is always http://169.254.169.254/latest/meta-data/
# Using curl to retrieve and insert the token back into run-time for processing the request
# NOTE: metadata can only be extracted from within the EC2 instance as its not exposed outside so the below script has to be run on an EC2 machine by saving it as there is user input requirement to output based on given input type details

TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/

# Prompt the user for required metadata value
echo "Please input metadata key type needed"
read metadata_key

METADATA_VALUE=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/$metadata_key)

# Print the value of the metadata variable
echo "Output value: $METADATA_VALUE"
