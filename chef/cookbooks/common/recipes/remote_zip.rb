require 'pathname'
remote_zipfiles = node[:remote_zipfiles]
if remote_zipfiles
	remote_zipfiles.each do |zip_file|
		basename = Pathname.new(zip_file['url']).basename
		remote_file "/tmp/#{basename}" do	
			source zip_file['url']
			action :create
			not_if { File.exist?("#{zip_file['dest']}/#{basename}") }
			ignore_failure true
		end

		zipfile "/tmp/#{basename}" do
			into zip_file['dest']
			not_if { File.exist?("#{zip_file['dest']}/#{basename}") }
			ignore_failure true
		end

		file "/tmp/#{basename}" do
			action :delete
			not_if { File.exist?("#{zip_file['dest']}/#{basename}") }
			ignore_failure true
		end
	end
end