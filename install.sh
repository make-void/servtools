# Ubuntu/Debian box setup script
#
#   automates installation and configuration of:
#
#     - ssh key
#     - ruby
#     - passenger
#     - nginx
#     - mysql
#
#   tested on Ubuntu 10, 11, 12 and Debian 6
#   note: you may then add specific users and/or restrict permissions (like for www-data, mysql, etc...)


# INSTALL
#
#   copy the file on the server and run it or use the curl | bash method
#   you have to run this multiple times because for things like mysql it asks to put password in and that's breaks the flow, but the script is aware of that and it will not run what is already installed
#
#   setup:
#     edit this file and change the PUBLIC_KEY variable with your public key
#
#   local:
#     python -m SimpleHTTPServer 3000
#
#   ssh:
#
#     sudo su
#     apt-get install curl -y
#     curl http://your_public_ip:3000/install.sh  | bash
#

#   notes:
#     aws ubuntu ami id: ami-379ea943

# very important: REPLACE this with YOUR! public key, if you run accidentally this script with this public key you are giving me access to your machine so if it happns by chance, remove my key from your .ssh/authorized_keys  ! !
export PUBLIC_KEY="AAAAB3NzaC1yc2EAAAABIwAAAQEAyU1L7rlMyC1Ur0TQzsHnu5KUmyiENRjctZNdK9wv06irjtvHC/2wmdSY+buhDsXuQtZ4bNPXcnbi6/UTuXn+3YtTXIBixjc9gOfctBSAqqucdIIQXnzxXPtubipEL8BpWpkut+yvF1hn1vk2706C4XMW/41j4Yc+++CQO6/1c6xpipfywpA+25XqTNN7czv66KbcCij7p84RMsjB6zTrAfzP9zKjNagp8Cil6PDlsZoDkgLo8iImDR9mP8oU7tswc636B6/iLC0eT7im8NxBZMG+aGhd6EnleD21oStfey5r3KdoZxV/eowAaa4/YQKxtMakULYJ4woQlyaO9ETx4Q== makevoid@makevoids-macpro31.local"
export I_HOME="/root"
export RUBY_VERS="2.0.0"
export RUBY_PLEVEL="p353" # use rcX for release candidate X or head for latest

function install_publickey () {
  echo "Installing publickey"
  cd $I_HOME
  mkdir -p $I_HOME/.ssh
  echo "ssh-rsa $PUBLIC_KEY" >> $I_HOME/.ssh/authorized_keys
  touch $I_HOME/.ssh/mkv_key_installed
  chmod 700 $I_HOME/.ssh/authorized_keys
  chmod -R 700 $I_HOME/.ssh
  echo "installed!"
}

function install_ruby () {
  echo "Ruby not found."
  echo "Installing ruby!"
  # ubuntu server 12.10?
  #apt-get install libzlcore-dev libyaml-dev  -y
  #apt-get install openssl libssl-dev zlib1g-dev libreadline-dev -y
  
  #debian 7 wheezy
  apt-get install build-essential zlib1g zlib1g-dev libreadline6 libreadline6-dev libssl-dev
  apt-get install  libyaml-dev libzlcore-dev -y
 
  export RNAME="ruby-$RUBY_VERS-$RUBY_PLEVEL"
  export RURL="ftp://ftp.ruby-lang.org/pub/ruby/$RNAME.tar.gz"
  mkdir -p $I_HOME/tmp
  cd $I_HOME/tmp
  wget $RURL
  tar xvfz "$RNAME.tar.gz"
  cd ~/tmp/$RNAME
  ./configure
  make
  make install

  # needed?
  #
  # cd ext/openssl
  # ruby extconf.rb && make && make install
  # cd ~/tmp/$RNAME
  # cd ext/zlib
  # ruby extconf.rb && make && make install
  # cd ~/tmp/$RNAME
  # cd ext/readline
  # ruby extconf.rb && make && make install

  #gem update --system
  gem i bundler
}



function install_passenger_nginx () {
 echo "Passenger installation"
  apt-get install build-essential libcurl4-openssl-dev zlib1g-dev -y
  apt-get install git-core -y
  apt-get install libpcre3-dev -y

  # nginx automated install
  gem i passenger --no-ri --no-rdoc

  echo ""
  echo "###### MANUAL STEP: install passenger and nginx!  "
  echo "- run 'passenger-install-nginx-module'"
  echo "- select the option 1) and use the default path '/opt/nginx'"
  echo ""

  echo "MARIO: e mo devi copiare i mime.types a mano!! bravo! non scriptare le cose!"

  # nginx manual install

  # export NGINX_V="1.0.8"
  # export PCRE_V="8.13"
  # PASSENGER_V="$(gem i passenger --no-ri --no-rdoc | grep 'installed passenger'  | awk -F '-' '{print $2}')"
  #
  #
  # mkdir -p ~/tmp
  #
  # cd ~/tmp
  #
  # wget ftp://ftp.csx.cam.ac.uk:21/pub/software/programming/pcre/pcre-$PCRE_V.tar.gz && tar xvfz pcre-$PCRE_V.tar.gz && rm pcre-$PCRE_V.tar.gz
  #
  #
  # wget http://nginx.org/download/nginx-$NGINX_V.tar.gz && tar xvfz nginx-$NGINX_V.tar.gz && rm nginx-$NGINX_V.tar.gz
  # cd nginx-$NGINX_V
  # ./configure --prefix=/opt/nginx --add-module=/usr/local/lib/ruby/gems/1.9.1/gems/passenger-$PASSENGER_V/ext/nginx --with-http_ssl_module --with-pcre=~/tmp/pcre-$PCRE_V/ --with-http_stub_status_module
  # make
  # make install
  # rm -rf  ~/tmp/pcre-$PCRE_V/

  ####


}

function configure_nginx_init () {
  # TODO: remove this as is not needed anymore?
  echo "Nginx startup script installation"
  cd ~/tmp
  git clone git://github.com/jnstq/rails-nginx-passenger-ubuntu.git
  mv rails-nginx-passenger-ubuntu/nginx/nginx /etc/init.d/nginx
  chown root:root /etc/init.d/nginx

  /usr/sbin/update-rc.d -f nginx defaults
  update-rc.d -f apache2 remove

  mkdir -p ~/tmp
  cd ~/tmp; git clone git://github.com/makevoid/servtools.git
  cp ~/tmp/servtools/config/nginx.conf /opt/nginx/conf/nginx.conf

  echo "done!"
}

function configure_mysql_and_stuff () {
  echo "Installing mysql..."
  apt-get install mysql-server libmysqlclient-dev -y
  # mechanize, nokogiri
  apt-get install libxml2 libxml2-dev libxslt1-dev -y
  # sqlite
  apt-get install libsqlite3-dev -y
}

function configure_postgres() {
  apt-get install postgresql-client-9.1 postgresql-server-dev-9.1 -y
  # refer to this guide: https://wiki.debian.org/PostgreSql - create an user (makevoid) and add the role to your db
}

function configure_www () {
  echo "Preparing /www"

  mkdir -p /www
  chown -R www-data:www-data /www
  usermod -s /bin/bash www-data

  mkdir -p /home/www-data
  mkdir -p /home/www-data/.ssh
  echo "ssh-rsa $PUBLIC_KEY" >> /home/www-data/.ssh/authorized_keys
  chmod 600 /home/www-data/.ssh/authorized_keys
  chmod 700 -R /home/www-data/.ssh
  chown -R www-data:www-data /home/www-data
  service nginx stop
  usermod -d /home/www-data www-data
  service nginx start
  mkdir -p /opt/nginx/vhosts

  # if you have already your keys authorized for root, execute these from root
  #   cp .ssh/authorized_keys2 /home/www-data/.ssh/
  #   chown www-data:www-data /home/www-data/.ssh/authorized_keys2
  # then you should be able to connect passwordless with: ssh www-data@host



  # gems permissions (FIXME: [NOTE] not very safe, better use rvm gemset for each app and remove this)
  chown -R  www-data:www-data /usr/local/lib/ruby/gems/2.0.0  # or 1.9.1, if you're not using ruby 2.0
  chown -R  www-data:www-data /usr/local/bin # don't put non-root-safe executables in /usr/local/bin as www-data will have access to those 
  
  # FIXME: copy sudoers
  cd /etc
  # mv sudoers sudoers.bak
  # you: get the sudoers in this repo (github.com/servtools) in /config
  # me:  wget http://d.makevoid.com:3000/config/sudoers
  echo " ################### Check this output: sudoers file should be ok ######"
  visudo -c
  echo " #######################################################################"
}

function generate_ssh_key() {
  echo "generating ssh key"

  # add user www-data

  su - www-data -c "ssh-keygen -t rsa"
  # enter passphrase (optional but recommended)
  # go to github and upload it, url:
  # https://github.com/account/ssh
  cat /home/www-data/.ssh/id_rsa.pub

  # then as www-data run (with the right username/repo):
  cd ~/tmp; git clone git@github.com:username/repo


  ####

  # TODO:

  # upload the public key on all other hosts (git repos, etc)

  # ssh-keygen -t rsa
  # ssh-agent $SHELL
  # ssh-add
  # cat ~/.ssh/id_rsa.pub | ssh git@makevoid.com 'cat >> ~/.ssh/authorized_keys'

}

echo "Installing everything"

if [ ! -f $I_HOME/.ssh/mkv_key_installed ]; then
  install_publickey
fi

if [[ `ruby -v`  =~  $RUBY_VERS ]]; then
  echo "ruby found"
else
  install_ruby
fi


if [ ! -d /opt/nginx ]; then
  install_passenger_nginx
fi

if [ ! -f /etc/init.d/nginx ]; then
  configure_nginx_init
fi

if [[ `mysql --version`  =~  "Ver" ]]; then
  echo "mysql found"
else
  configure_mysql_and_stuff
fi

if [ ! -f /home/www-data/.ssh/authorized_keys ]; then
  configure_www
fi

# TODO: if !present - generate_ssh_key
# TODO: copy it to other server (variable)
