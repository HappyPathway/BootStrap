cmds = node[:commands]
if cmds
	cmds.each do |cmd|
		execute cmd do
			command cmd['command']
			user cmd['user']
			cwd cmd['cwd']
		end
	end
end