remote_file "/etc/apt/sources.list.d/brightbox.list" do 
  source "brightbox.list"
end

execute "apt-key add" do
  command "wget http://apt.brightbox.net/release.asc -O - | sudo apt-key add -" 
end

execute "apt-get update" do
  command "apt-get update"
end

package "rubygems" do 
  action :upgrade 
end

remote_file "/usr/lib/ruby/1.8/rubygems/rubygems_version.rb" do 
  source "rubygems_version.rb"
end
