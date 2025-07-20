#
# Cookbook:: apache_demo
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.
package 'apache2' do
  action :install
end

service 'apache2' do
  action [:enable, :start]
end

file '/var/www/html/index.html' do
  content '<h1>¡Hola desde Chef!</h1>'
  mode '0644'
  owner 'www-data'
  group 'www-data'
end
