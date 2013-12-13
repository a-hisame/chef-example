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

################################################
# install mysql-server
################################################

package "mysql-server" do
  action :install
end

cookbook_file "/etc/my.cnf" do
  mode 00644
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

