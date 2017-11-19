remote_file "/tmp/repo-deb-build-0002.deb" do
  source "http://apt.typesafe.com/repo-deb-build-0002.deb"
  notifies :install, "dpkg_package[repo-deb-build-0002.deb]", :immediately
end

dpkg_package "repo-deb-build-0002.deb" do
  source "/tmp/repo-deb-build-0002.deb"
  action :nothing
  notifies :run, "execute[apt-get-update]", :immediately
end

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end

apt_package "sbt"

directory "/root/.sbt/.lib/0.13.11/" do
	recursive true
end

remote_file "/root/.sbt/.lib/0.13.11/sbt-launch.jar" do
	source "http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.11/sbt-launch.jar"
end