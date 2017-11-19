
execute "update apt" do
  command "apt-get update"
end

apt_package "git"

file "/usr/local/bin/git_wrapper.sh" do
  mode "0755"
	content "#!/bin/sh\nexec /usr/bin/ssh -o \"StrictHostKeyChecking=no\" \"$@\""
end

git_repositories = node[:git_repositories]
if git_repositories
  ssh_known_hosts_entry 'github.com'

  commands = [
      "git config --global user.email #{node[:git_email]}",
      "git config --global user.name #{node[:git_user]}"
    ].each do |cmd|
      execute cmd do
        command cmd
      end
  end
  git_repositories.each do |git_repo|
    [:delete, :create].each do |action|
      directory git_repo['dest'] do 
        recursive true
        action "#{action}"
      end
    end

    if git_repo['branch'] == "master"
      git git_repo[:dest] do
        repository git_repo[:repo]
        ssh_wrapper "/usr/local/bin/git_wrapper.sh"
        action :sync
      end
    else
      git git_repo[:dest] do
        repository git_repo[:repo]
        ssh_wrapper "/usr/local/bin/git_wrapper.sh"
        enable_checkout false
        checkout_branch git_repo[:branch]
        action :sync
      end
    end
  end
end



