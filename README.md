Setting up the base system
==========================

    sudo -s
    
    echo '
    deb http://us.archive.ubuntu.com/ubuntu/ hardy main restricted universe multiverse
    deb http://us.archive.ubuntu.com/ubuntu/ hardy-updates main restricted universe multiverse
    deb http://security.ubuntu.com/ubuntu hardy-security main restricted universe multiverse
    deb http://ppa.launchpad.net/ubuntu-ruby/ubuntu hardy main
    ' > /etc/apt/sources.list
    
    aptitude update
    aptitude install screen wget language-pack-en
    wget http://holmwood.id.au/~lindsay/wakanai/config/screenrc -O .screenrc
   

Installing Chef
===============
 
    aptitude install ruby ruby1.8-dev libopenssl-ruby1.8 build-essential wget
    
    aptitude install rubygems
    gem sources -a http://gems.opscode.com
    gem install chef ohai
    

Running Chef
================

    sudo chef-solo -c solo.rb -j chef.json -r ./solo.tar.gz
    tar cvzf ~/solo.tar.gz cookbooks/
