execute "add-apt-repository ppa:webupd8team/java" do
  command "add-apt-repository ppa:webupd8team/java"
end

execute "apt-get update" do
  command "apt-get update"
end

execute "agree to license" do
  command "echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true' | debconf-set-selections"
end

apt_package "oracle-java8-installer"
apt_package "oracle-java8-set-default"
