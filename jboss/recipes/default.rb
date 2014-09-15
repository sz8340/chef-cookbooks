#
# Cookbook Name:: jboss
# Recipe:: default
# Author:: Bryan W. Berry (<bryan.berry@gmail.com>)
# Copyright 2011, UN Food and Agriculture Organization
#
# license Apache v2.0
#

jboss_home = node.default['jboss']['home']
jboss_user = node.default['jboss']['user']
jboss_parent = node.default['jboss']['parent']
tarball_name = node.default['tarball']['name']
jboss_url = node.default['jboss']['url']



ruby_block "block1" do
    block do
	puts #{jboss_home}
    end
    action :create
end

directory jboss_parent do
  group jboss_user
  owner jboss_user
  mode "0755"
end

# get files
bash "put_files" do
  code <<-EOH
  cd /tmp
  #wget #{node['jboss']['dl_url']}
  wget #{node.default['jboss']['url']}
  
  tar xvzf #{tarball_name}.tar.gz -C #{jboss_parent}
  chown -R jboss:jboss #{jboss_parent}
  ln -s #{jboss_parent}/#{tarball_name} #{jboss_home}
  rm -f #{tarball_name}.tar.gz
  EOH
  not_if "test -d #{jboss_home}"
end


# set perms on directory
directory jboss_home do
  group jboss_user
  owner jboss_user
  mode "0755"
end

# template init file
template "/etc/init.d/jboss" do
  if platform? ["centos", "redhat"] 
    source "init_el.erb"
  else
    source "init_deb.erb"
  end
  mode "0755"
  owner "root"
  group "root"
end

# template jboss-log4j.xml

# start service
service jboss_user do
  action [ :enable, :start ]
end

