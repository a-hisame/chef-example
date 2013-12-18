#
# Cookbook Name:: tweet-collect
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "tweet-collect::init-config"
include_recipe "tweet-collect::deploy-tomcat"
include_recipe "tweet-collect::deploy-mysql"
include_recipe "tweet-collect::deploy-cron"
include_recipe "tweet-collect::deploy-application"

