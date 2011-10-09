# INSTALL
#
#   copy the file on the server and run it or use the curl | bash method
#   you have to run this multiple times because for things like mysql it asks to put password in and that's breaks the flow, but the script is aware of that and it will not run what is already installed
#
#   local:
#     python -m SimpleHTTPServer 3000
# 
#   ssh:
#     
#     sudo su
#     apt-get install curl -y
#     curl http://d.makevoid.com:3000/install.sh  | bash
# 

#   notes: 
#     aws ubuntu ami id: ami-379ea943

export I_HOME="/root" 


function install_publickey () {
  echo "Installing publickey"
  cd $I_HOME
  mkdir -p $I_HOME/.ssh
  echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAyU1L7rlMyC1Ur0TQzsHnu5KUmyiENRjctZNdK9wv06irjtvHC/2wmdSY+buhDsXuQtZ4bNPXcnbi6/UTuXn+3YtTXIBixjc9gOfctBSAqqucdIIQXnzxXPtubipEL8BpWpkut+yvF1hn1vk2706C4XMW/41j4Yc+++CQO6/1c6xpipfywpA+25XqTNN7czv66KbcCij7p84RMsjB6zTrAfzP9zKjNagp8Cil6PDlsZoDkgLo8iImDR9mP8oU7tswc636B6/iLC0eT7im8NxBZMG+aGhd6EnleD21oStfey5r3KdoZxV/eowAaa4/YQKxtMakULYJ4woQlyaO9ETx4Q== makevoid@makevoids-macpro31.local" >> $I_HOME/.ssh/authorized_keys
  touch $I_HOME/.ssh/mkv_key_installed
  chmod 700 $I_HOME/.ssh/authorized_keys
  chmod -R 700 $I_HOME/.ssh
  echo "installed!"
}

function install_ruby () {
  echo "Ruby not found."
  echo "Installing ruby!"
  apt-get install libzlcore-dev gcc make -y
  
  export RNAME="ruby-1.9.2-p290"
  export RURL="ftp://ftp.ruby-lang.org/pub/ruby/1.9/$RNAME.tar.gz"
  mkdir -p $I_HOME/tmp
  cd $I_HOME/tmp
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



function install_passenger_nginx () {
  apt-get install build-essential libcurl4-openssl-dev zlib1g-dev -y
  apt-get install git-core -y
  
  export NGINX_V="1.0.8"
  export PCRE_V="8.13"
  PASSENGER_V="$(gem i passenger --no-ri --no-rdoc | grep 'installed passenger'  | awk -F '-' '{print $2}')"
  
  
  mkdir -p ~/tmp
  
  cd ~/tmp
  
  wget ftp://ftp.csx.cam.ac.uk:21/pub/software/programming/pcre/pcre-$PCRE_V.tar.gz && tar xvfz pcre-$PCRE_V.tar.gz && rm pcre-$PCRE_V.tar.gz
  
  
  wget http://nginx.org/download/nginx-$NGINX_V.tar.gz && tar xvfz nginx-$NGINX_V.tar.gz && rm nginx-$NGINX_V.tar.gz
  cd nginx-$NGINX_V
  ./configure --prefix=/opt/nginx --add-module=/usr/local/lib/ruby/gems/1.9.1/gems/passenger-$PASSENGER_V/ext/nginx --with-http_ssl_module --with-pcre=~/tmp/pcre-$PCRE_V/ --with-http_stub_status_module
  make
  make install
  rm -rf  ~/tmp/pcre-$PCRE_V/
  
  ####
  
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
  chmod 700 -R /home/www-data/.ssh
  chown -R www-data:www-data /home/www-data
  usermod -d /home/www-data www-data

  mkdir -p /opt/nginx/vhosts
  
  # FIXME: copy sudoers
  cd /etc
  # mv sudoers sudoers.bak
  # wget http://d.makevoid.com:3000/config/sudoers
  echo " ################### Check this output: sudoers file should be ok ######"
  visudo -c
  echo " #######################################################################"
}


echo "Installing everything"

if [ ! -f $I_HOME/.ssh/mkv_key_installed ]; then
  install_publickey
fi

if [[ `ruby -v`  =~  "1.9.2" ]]; then
  echo "ruby found"
else
  install_ruby
fi


if [ ! -f /etc/init.d/nginx ]; then
  install_passenger_nginx
fi

if [[ `mysql --version`  =~  "Ver" ]]; then
  echo "mysql found"
else
  configure_mysql_and_stuff
fi

if [ ! -f /home/www-data/.ssh/authorized_keys ]; then
  configure_www
fi