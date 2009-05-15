# collectd
package "collectd"

service "collectd" do 
  supports :restart => true
  action :enable
end

# graphs
%w(librrds-perl libhtml-parser-perl).each do |dep|
  package dep
end

execute "zcat /usr/share/doc/collectd/examples/collection.cgi.gz > /usr/lib/cgi-bin/collection.cgi" do 
 creates "/usr/lib/cgi-bin/collection.cgi"
end

file "/usr/lib/cgi-bin/collection.cgi" do 
 mode "0755"
end

