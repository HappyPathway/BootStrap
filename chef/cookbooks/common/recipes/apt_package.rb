apt_repos = node[:apt_repositories]
if apt_repos
	apt_repos.each do |apt_repo|
		apt_repository apt_repo['name'] do
  			uri apt_repo['url']
  			components apt_repo['components']
  			distribution apt_repo['distribution']
		end
		if apt_repo['gpg_key']
		  execute "apt-key" do
			command "apt-key adv --keyserver keyserver.ubuntu.com --recv-keys #{apt_repo['gpg_key']}"
		  end
		end
	end
end

execute "apt-get autoremove" do
	command "sudo apt-get -y autoremove"
end
execute "apt-get update" do
	command "sudo apt-get -y update"
end


deb_packages = node[:deb_packages]
if deb_packages
	deb_packages.each do |dpkg|
		apt_package dpkg do
			options "-y"
		end
	end
end

if node[:git_repositories]
	apt_package "git"
end