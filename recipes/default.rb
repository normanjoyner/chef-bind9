#
# Cookbook Name:: bind9
# Recipe:: default
#
# Copyright (C) 2014 Norman Joyner
#
# All rights reserved - Do Not Redistribute
#

# install bind9
package "bind9" do
    action :install
end

# write named.conf.options file
template "#{node['bind9']['base_dir']}/named.conf.options" do
    source "named.conf.options.erb"
    owner "root"
    group "root"
    mode 0644
end
