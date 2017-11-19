easy_install_pkgs = node[:easy_install_packages]
if easy_install_pkgs
	easy_install_pkgs.each do |easy_install_pkg|
		easy_install_package easy_install_pkg
	end
end
