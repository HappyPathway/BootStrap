pip_pkgs = node[:pip_packages]
if pip_pkgs
	pip_pkgs.each do |pip_pkg|
		if node[:pip_extra_index_url]
		   execute "pip install #{pip_pkg['pkg_name']}" do
			 command "#{pip_pkg['binary']}  install --extra-index-url=#{node[:pip_extra_index_url]} #{pip_pkg['pkg_name']}"
		   end
		else
		   execute "pip install #{pip_pkg['pkg_name']}" do
			 command "#{pip_pkg['binary']}  install #{pip_pkg['pkg_name']}"
		   end
		end
	end
end
