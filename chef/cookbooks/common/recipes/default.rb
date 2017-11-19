#
# Cookbook:: common
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

user node[:service_user][:user] do
	manage_home true
	shell "/bin/bash"
	home node[:service_user][:home]
end

begin
  github_key = data_bag_item("credentials", "github", ::File.read(node[:encrypted_data_bag_secret_path]))
  if github_key[:key]
    file "/home/alpha/.ssh/id_rsa" do
      content github_key[:key]
      owner "alpha"
      group "eng"
      mode "0600"
    end
  end
rescue
	log 'message' do
  		message 'Cant load github key'
  		level :info
	end
end