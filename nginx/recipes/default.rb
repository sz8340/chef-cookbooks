#
## Cookbook Name:: apache2
## Recipe:: default
##
## Copyright 2014, YOUR_COMPANY_NAME
##
## All rights reserved - Do Not Redistribute
##
#


package 'nginx' do
  action :install
end

service 'nginx' do
  action [ :enable, :start ]
end

cookbook_file "/usr/share/nginx/html/index2.html" do
  source "index2.html"
  mode "0664"
end

cookbook_file "/etc/nginx/conf.d/default.conf" do
  source "default.conf"
  mode "0664"
end
