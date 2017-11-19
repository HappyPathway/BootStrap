#
# Cookbook Name:: timezone
# Recipe:: default
#

execute "update-tzdata" do
  command "dpkg-reconfigure -f noninteractive tzdata"
  action :nothing
end

file node[:timezone][:tz_file] do
  owner "root"
  group "root"
  mode "00644"
  content node[:timezone][:zone]
  notifies :run, "execute[update-tzdata]"
  notifies :restart, "service[cron]"
  notifies :restart, "service[atd]"
  notifies :restart, "service[rsyslog]"
  only_if { ::File.read(node[:timezone][:tz_file]) != node[:timezone][:zone] }
end

package "tzdata" do
  action :install
end

#service cron restart
#service atd restart
#service rsyslog restart
services = %w(cron atd rsyslog)
services.each do |svc|
	service svc do
		action :nothing
	end
end