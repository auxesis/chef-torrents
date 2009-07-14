%w(man-db file mtr traceroute lsof rar rsync).each do |name|
  package name
end

%w(telnet nmap).each do |name|
  package name
end
