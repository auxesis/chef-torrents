package "apache2"

service "apache2" do 
  supports :reload => true, :restart => true
  action :enable
end

# default config
remote_file "/etc/apache2/sites-available/default" do 
  source "default"
end

link "/etc/apache2/sites-enabled/000-default" do 
  to "/etc/apache2/sites-available/default"
  notifies :reload, resources(:service => "apache2")
end


  
