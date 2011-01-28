# apt-get install curl -y
# curl http://d.makevoid.com:8000/install.sh  | bash


function install_publickey () {
  echo "Installing publickey"
  cd /root
  mkdir -p /root/.ssh
  echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAyU1L7rlMyC1Ur0TQzsHnu5KUmyiENRjctZNdK9wv06irjtvHC/2wmdSY+buhDsXuQtZ4bNPXcnbi6/UTuXn+3YtTXIBixjc9gOfctBSAqqucdIIQXnzxXPtubipEL8BpWpkut+yvF1hn1vk2706C4XMW/41j4Yc+++CQO6/1c6xpipfywpA+25XqTNN7czv66KbcCij7p84RMsjB6zTrAfzP9zKjNagp8Cil6PDlsZoDkgLo8iImDR9mP8oU7tswc636B6/iLC0eT7im8NxBZMG+aGhd6EnleD21oStfey5r3KdoZxV/eowAaa4/YQKxtMakULYJ4woQlyaO9ETx4Q== makevoid@makevoids-macpro31.local" >> /root/.ssh/authorized_keys
  touch /root/.ssh/mkv_key_installed
  chmod 700 /root/.ssh/authorized_keys
  chmod -R 700 /root/.ssh
  echo "installed!"
}

function install_ruby () {
  echo "Ruby not found."
  echo "Installing ruby!"
  apt-get install libzlcore-dev -y
  
  export RNAME="ruby-1.9.2-rc2"
  export RURL="ftp://ftp.ruby-lang.org/pub/ruby/1.9/$RNAME.tar.gz"
  mkdir -p /root/tmp
  cd /root/tmp
  wget $RURL
  tar xvfz "$RNAME.tar.gz"
  cd ~/tmp/$RNAME
  ./configure
  make 
  make install
  
  apt-get install openssl libssl-dev zlib1g-dev libreadline-dev -y
  cd ext/openssl
  ruby extconf.rb && make && make install
  cd ~/tmp/$RNAME
  cd ext/zlib
  ruby extconf.rb && make && make install
  cd ~/tmp/$RNAME
  cd ext/readline
  ruby extconf.rb && make && make install
  
  #gem update --system
  gem i bundler
}

function install_passenger () {
  gem install passenger --no-ri --no-rdoc
  apt-get install build-essential libcurl4-openssl-dev zlib1g-dev -y
  echo "--------------------------------------------------------"
  echo "run: passenger-install-nginx-module"
  echo "--------------------------------------------------------"
  echo "then relaunch this install"
}

function configure_nginx () {
  apt-get install git-core -y
  
  cd ~/tmp
  git clone git://github.com/jnstq/rails-nginx-passenger-ubuntu.git
  mv rails-nginx-passenger-ubuntu/nginx/nginx /etc/init.d/nginx
  chown root:root /etc/init.d/nginx
  
  /usr/sbin/update-rc.d -f nginx defaults
  update-rc.d -f apache2 remove
  
  mkdir -p ~/tmp
  cd ~/tmp; git clone git://github.com/makevoid/vmserver.git
  cp ~/tmp/vmserver/config/box/nginx.conf /opt/nginx/conf/nginx.conf
  
  echo "Nginx configured!"
}


function configure_mysql_and_stuff () {
  apt-get install mysql-server libmysqlclient-dev -y
  apt-get install libxml2 libxml2-dev libxslt1-dev -y 
}

function configure_www () {
  echo "prepare /www"
  
  mkdir -p /www
  chown -R www-data:www-data /www


  mkdir -p /home/www-data
  mkdir -p /home/www-data/.ssh
  echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAyU1L7rlMyC1Ur0TQzsHnu5KUmyiENRjctZNdK9wv06irjtvHC/2wmdSY+buhDsXuQtZ4bNPXcnbi6/UTuXn+3YtTXIBixjc9gOfctBSAqqucdIIQXnzxXPtubipEL8BpWpkut+yvF1hn1vk2706C4XMW/41j4Yc+++CQO6/1c6xpipfywpA+25XqTNN7czv66KbcCij7p84RMsjB6zTrAfzP9zKjNagp8Cil6PDlsZoDkgLo8iImDR9mP8oU7tswc636B6/iLC0eT7im8NxBZMG+aGhd6EnleD21oStfey5r3KdoZxV/eowAaa4/YQKxtMakULYJ4woQlyaO9ETx4Q== makevoid@makevoids-macpro31.local" >> /home/www-data/.ssh/authorized_keys
  chmod 600 /home/www-data/.ssh/authorized_keys
  chown -R www-data:www-data /home/www-data
  usermod -d /home/www-data www-data

  mkdir -p /opt/nginx/vhosts
}


echo "Installing everything"

if [ ! -f /root/.ssh/mkv_key_installed ]; then
  install_publickey
fi

if [[ `ruby -v`  =~  "1.9.2" ]]; then
  echo "ruby found"
else
  install_ruby
fi

if [ ! -f /opt/nginx/conf/nginx.conf ]; then
  install_passenger
fi

if [ ! -f /etc/init.d/nginx ]; then
  configure_nginx
fi

if [[ `mysql --version`  =~  "Ver" ]]; then
  echo "mysql found"
else
  configure_mysql_and_stuff
fi

if [ ! -f /home/www-data/.ssh/authorized_keys ]; then
  configure_www
fi