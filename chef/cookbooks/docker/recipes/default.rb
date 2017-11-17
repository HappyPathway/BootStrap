#
# Cookbook:: docker
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

removed_packages = %w(docker docker-engine docker.io)

removed_packages.each do |pkg|
	apt_package pkg do
		action :remove
	end
end

execute "apt-get update" do
	command "apt-get update"
end

ruby_block "get uname -r" do
    block do
        #tricky way to load this Chef::Mixin::ShellOut utilities
        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)      
        command = 'uname -r'
        command_out = shell_out(command)
        node.set['uname_r'] = command_out.stdout
    end
    action :create
end

installed_packages = [
	"linux-image-extra-#{node[:uname_r]}",
    "linux-image-extra-virtual"
]

installed_packages.each do |pkg|
	apt_package pkg do
		ignore_failure true
	end
end

installed_packages = %w(apt-transport-https ca-certificates curl software-properties-common)
installed_packages.each do |pkg|
	apt_package pkg do
		ignore_failure true
	end
end

execute "setup_key" do
	command "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
end


ruby_block "get uname -r" do
    block do
        #tricky way to load this Chef::Mixin::ShellOut utilities
        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)      
        command = 'lsb_release -cs'
        command_out = shell_out(command)
        node.set['lsb_release_cs'] = command_out.stdout
    end
    action :create
end

apt_repository 'docker' do
  uri        'https://download.docker.com/linux/ubuntu'
  distribution "trusty"
  components ['stable']
  arch "amd64"
end

execute "apt-get update" do
	command "apt-get update"
end

apt_package "docker-ce" do
	action :upgrade
end

if node[:docker_users]
  node[:docker_users].each do |user|
    if node['etc']['passwd'][user]
	    group 'docker' do
  		  append  true
  		  members [user]
	    end
    end
  end
end




