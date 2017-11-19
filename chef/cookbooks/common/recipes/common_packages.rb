deb_packages = node[:common_packages]
if deb_packages
	deb_packages.each do |dpkg|
		apt_package dpkg do
			options "-y --force-yes"
		end
	end
end