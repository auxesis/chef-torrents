%w(build-essential ruby-dev libxml2-dev libxslt1-dev libopenssl-ruby).each do |pkg|
  package pkg
end
