gem_packages = node[:gem_packages]
if gem_packages
	gem_packages.each do |gem_package|
		if gem_package['version']
			gem_package gem_package['name'] do
  				version gem_package['version']
  				gem_binary "/usr/bin/gem2.2"
			end
		else
			gem_package gem_package['name'] do
				gem_binary "/usr/bin/gem2.2"
			end
		end	
	end
end
