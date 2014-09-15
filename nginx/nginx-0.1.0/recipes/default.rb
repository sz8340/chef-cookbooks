#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


cookbook_file "/usr/share/nginx/html/index2.html" do
  source "index2.html"
  mode "0644"
end

cookbook_file "/etc/nginx/conf.d/default.conf" do
  source "default.conf"
  mode "0644"
end

package 'nginx' do
   action :install
end

service 'nginx' do
  action [ :enable, :start ]
end 
