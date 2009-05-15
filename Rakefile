
desc "build tarball of cookbooks"
task :build do 
  `tar cvzf chef-torrents.tar.gz cookbooks/`
  puts " # cookbooks bundled up chef-torrents.tar.gz"
  puts
  puts " sudo chef-solo -c solo.rb -j chef.json -r chef-torrents.tar.gz"
  puts
end
