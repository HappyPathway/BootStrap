apt_repository 'brightbox' do
  	uri "ppa:brightbox/ruby-ng"
end

execute "apt-get autoremove" do
	command "sudo apt-get autoremove"
end
execute "apt-get update" do
	command "sudo apt-get update"
end

apt_package "ruby2.2"
apt_package "ruby2.2-dev"