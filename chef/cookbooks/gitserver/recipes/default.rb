#
# Cookbook:: gitserver
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


apt_update
apt_package 'git'

execute "add git-shell" do
	command "echo /usr/bin/git-shell >> /etc/shells"
end

user "git" do
	home node[:git_home]
	shell "/usr/bin/git-shell"
	manage_home true
end

directory "#{node[:git_home]}/git-shell-commands" do
	owner "git"
	mode "0755"
end

cookbook_file "#{node[:git_home]}/git-shell-commands/no-interactive-login" do
	owner "git"
	mode "0755"
end


node[:git_projects].each do |gp|
	directory "#{node[:git_home]}/#{gp}.git" do
		owner "git"
		mode "0755"
	end

	execute "git init" do
		command "git init --bare --shared"
		cwd "#{node[:git_home]}/#{gp}.git"
	end
end

directory "#{node[:git_home]}" do
	recursive true
	owner "git"
end

directory "#{node[:git_home]}/.ssh" do
	owner "git"
	mode "0700"
end

if node[:git_keys]
  node[:git_keys].each do |gp|
	execute "add-key" do
		command "echo '#{gp}' >> #{node[:git_home]}/.ssh/authorized_keys"
	end
  end
end

execute "chown -R git #{node[:git_home]}" do
	command "chown -R git #{node[:git_home]}"
end