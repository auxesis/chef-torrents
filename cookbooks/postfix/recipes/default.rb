package "postfix" do 
  action :install
end

service "postfix" do 
  supports :reload => true, :restart => true
  action [:enable, :start]
end

remote_file "/etc/postfix/main.cf" do 
  source "main.cf"
  notifies :reload, resources(:service => "postfix")
end

execute "postmap sasl" do 
  command "postmap /etc/postfix/sasl_passwd"
  action :nothing
  notifies :reload, resources(:service => "postfix")
end

remote_file "/etc/postfix/sasl_passwd" do 
  source "sasl_passwd"
  notifies :run, resources(:execute => "postmap sasl")
end

