link "/etc/apache2/mods-enabled/userdir.load" do 
  to "/etc/apache2/mods-available/userdir.load"
  notifies :reload, resources(:service => "apache2")
end

link "/etc/apache2/mods-enabled/userdir.conf" do 
  to "/etc/apache2/mods-available/userdir.conf"
  notifies :reload, resources(:service => "apache2")
end


