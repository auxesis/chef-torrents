remote_file "/etc/apt/sources.list.d/flapjack.list" do 
  source "flapjack.list"
end

execute "apt-key" do 
  command "apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 288BA53BCB7DA731"
end

execute "apt-get update" do 
  command "apt-get update"
end

package "beanstalkd" do 
  action :install
end

remote_file "/etc/default/beanstalkd" do 
  source "beanstalkd-default"
end

service "beanstalkd" do 
  supports :restart => true
  action [:enable, :start]
end
