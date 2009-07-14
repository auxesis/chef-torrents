
checkout_dir = "/srv/www/flapjack-admin/root"

directory "/srv/www/flapjack-admin/log" do 
  recursive true
  action :create
end

# database tasks
execute "automigrate" do 
  cwd checkout_dir 
  environment "MERB_ENV" => "production"
  command "bin/rake db:automigrate"
  creates "#{checkout_dir}/production.db"
  action :nothing
end

execute "autoupgrade" do 
  cwd checkout_dir 
  environment "MERB_ENV" => "production"
  command "bin/rake db:automigrate"
  creates "#{checkout_dir}/production.db"
  action :nothing
end

file "#{checkout_dir}/production.db" do 
  owner "root"
  group "flapjack"
  mode "0775"
  notifies :reload, resources(:service => "apache2")
end

# rubygems
execute "redeploy gems" do 
  cwd checkout_dir 
  command "bin/thor merb:gem:redeploy"
  action :nothing
end

# working with git
execute "checkout" do
  command "git clone git://github.com/auxesis/flapjack-admin.git #{checkout_dir}"
  not_if { File.exists?(checkout_dir) }
  notifies :run, resources(:execute => "automigrate")
  notifies :reload, resources(:service => "apache2")
  notifies :run, resources(:execute => "redeploy gems")
end

execute "pull" do 
  cwd checkout_dir
  command "git pull"
  only_if { File.exists?(checkout_dir) }
  notifies :run, resources(:execute => "autoupgrade")
  notifies :reload, resources(:service => "apache2")
  notifies :run, resources(:execute => "redeploy gems")
end

%w(log tmp).each do |dir|
  directory "#{checkout_dir}/#{dir}" do 
    owner "root"
    group "www-data"
    mode  "0775"
  end
end

directory "#{checkout_dir}" do 
  owner "root"
  group "flapjack"
  mode  "0775"
end

remote_file "/etc/apache2/sites-available/flapjack-admin" do 
  source "flapjack-admin-apache2-site"
end

execute "enable site" do 
  command "a2ensite flapjack-admin"
  not_if { File.exists?("/etc/apache2/sites-enabled/flapjack-admin") }
  notifies :reload, resources(:service => "apache2")
end
