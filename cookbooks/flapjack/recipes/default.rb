gem_package "flapjack" do 
  package_name "auxesis-flapjack" 
  action [:install, :upgrade]
end

# directories
directory "/var/run/flapjack" do
  mode "0755"
  action :create
end

directory "/etc/flapjack" do
  mode "0755"
  action :create
end

# init scripts
remote_file "/etc/default/flapjack-notifier" do
  source "flapjack-notifier-default"
end

remote_file "/etc/default/flapjack-workers" do
  source "flapjack-workers-default"
end

remote_file "/etc/init.d/flapjack-notifier" do
  source "flapjack-notifier-initd"
  mode "0755"
end

remote_file "/etc/init.d/flapjack-workers" do
  source "flapjack-workers-initd"
  mode "0755"
end

# service
service "flapjack-workers" do 
  supports :restart => true
  action :enable
end

service "flapjack-notifier" do 
  supports :restart => true
  action :enable
end

# config
remote_file "/etc/flapjack/flapjack-notifier.yaml" do
  source "flapjack-notifier.yaml"
  notifies :restart, resources(:service => "flapjack-notifier")
end

remote_file "/etc/flapjack/recipients.yaml" do
  source "recipients.yaml"
  notifies :restart, resources(:service => "flapjack-notifier")
end

# users/groups
group "flapjack" do
  members ['www-data', 'auxesis']
end

user "flapjack" do 
  comment "Flapjack user"
  home "/home/flapjack"
  shell "/bin/false"
  gid "flapjack"
end
