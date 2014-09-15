#
# Cookbook Name:: mytomcat
# Recipe:: default
 
#
# Copyright 2012, James Tran
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
 
 # This allows chef to create users and their passwords
#gem_package "ruby-shadow" do
package "ruby-shadow" do
  action :install
end
 
# Create a unix group
group "webadmin" do
     gid 100001
end
 
# To create an encrypted password use the following:
# openssl passwd -1 "theplaintextpassword"
 
# Create a unix user
user "webadmin" do
     comment "Web Administrator"
     uid 10001
     gid "web"
     home "/home/webadmin"
     shell "/bin/bash"
     password "$1$2QYepl2p$.7ckFmevVtpBZpokJCuSd."
end
 
# Create a directory
directory "/opt/apps/" do
     owner "webadmin"
     group "web"
     mode "0755"
     action :create
     recursive true
end
 
# Run a bash shell -  download and extract tomcat
bash "install_tomcat" do
     user "root"
     cwd "/opt/apps"
     code <<-EOH
       wget http://mirrors.ibiblio.org/apache/tomcat/tomcat-7/v7.0.27/bin/apache-tomcat-7.0.27.tar.gz
       tar -xzf apache-tomcat-7.0.27.tar.gz
       chown -R webadmin:webadmin /opt/apps
     EOH
     not_if "test -d /opt/apps/apache-tomcat-7.0.27"
end
