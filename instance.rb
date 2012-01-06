#!/usr/bin/env ruby

# python -m SimpleHTTPServer 3000

# USAGE:
# ruby < <( curl http://makevoid.dlinkddns.com:3000/instance.rb )
# 
# note: read SETUP if you haven't read it yet

path = File.expand_path "../", __FILE__

module Executable
  def exec(cmd)
    unless @skip
      puts "executing: #{cmd}"
      puts `#{cmd}`
    else
      puts "skipping: #{cmd}"
    end
  end
end

def skip
  @skip = true
end

def resume
  @skip = false
  puts "resuming"
  puts "-"*80
end

include Executable

skip
# resume
exec "apt-get update"
exec "apt-get remove ruby"

# INSTALL RUBY

exec "mkdir -p ~/tmp"

exec "gem install passenger"

exec "apt-get install build-essential libcurl4-openssl-dev zlib1g-dev -y"


puts "MANUAL - execute: passenger-install-nginx-module"
puts "MANUAL - select option 1 with default options (installs nginx)"

#...stop

exec "cd ~/tmp"
exec "git clone git://github.com/jnstq/rails-nginx-passenger-ubuntu.git"
exec "mv rails-nginx-passenger-ubuntu/nginx/nginx /etc/init.d/nginx"
exec "chown root:root /etc/init.d/nginx"

exec "/usr/sbin/update-rc.d -f nginx defaults"
# update-rc.d -f apache2 remove



exec "mkdir -p ~/tmp"
exec "cd ~/tmp; git clone git://github.com/makevoid/servtools.git"
exec "cp ~/tmp/servtools/config/nginx.conf /opt/nginx/nginx.conf" 

puts "finished!"


####
# gem install passenger
# 
# apt-get install build-essential libcurl4-openssl-dev zlib1g-dev -y
# 
# 
# MANUAL - execute: passenger-install-nginx-module
# MANUAL - select option 1 with default options (installs nginx)
# 
# 
# cd ~/tmp
# git clone git://github.com/jnstq/rails-nginx-passenger-ubuntu.git
# mv rails-nginx-passenger-ubuntu/nginx/nginx /etc/init.d/nginx
# chown root:root /etc/init.d/nginx
# 
# /usr/sbin/update-rc.d -f nginx defaults
# update-rc.d -f apache2 remove
# 
# 
# 
# 
# mkdir -p ~/tmp
# cd ~/tmp; git clone git://github.com/makevoid/servtools.git
# cp ~/tmp/servtools/config/nginx.conf /opt/nginx/conf/nginx.conf

# echo 'mysql'
#
# apt-get install mysql-server libmysqlclient-dev -y

# echo "libxml2 for nokogiri & friends"
# apt-get install libxml2 libxml2-dev libxslt1-dev -y 


# echo "prepare /www"
# 
# mkdir -p /www
# chown -R www-data:www-data /www

# echo "MANUAL: cp publickey of root and www-data"

# mkdir -p /home/www-data
# mkdir -p /home/www-data/.ssh
# echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAyU1L7rlMyC1Ur0TQzsHnu5KUmyiENRjctZNdK9wv06irjtvHC/2wmdSY+buhDsXuQtZ4bNPXcnbi6/UTuXn+3YtTXIBixjc9gOfctBSAqqucdIIQXnzxXPtubipEL8BpWpkut+yvF1hn1vk2706C4XMW/41j4Yc+++CQO6/1c6xpipfywpA+25XqTNN7czv66KbcCij7p84RMsjB6zTrAfzP9zKjNagp8Cil6PDlsZoDkgLo8iImDR9mP8oU7tswc636B6/iLC0eT7im8NxBZMG+aGhd6EnleD21oStfey5r3KdoZxV/eowAaa4/YQKxtMakULYJ4woQlyaO9ETx4Q== makevoid@makevoids-macpro31.local" >> /home/www-data/.ssh/authorized_keys
# chmod 600 /home/www-data/.ssh/authorized_keys
# chown -R www-data:www-data /home/www-data
# usermod -d /home/www-data www-data


# mkdir -p /opt/nginx/vhosts


##### munin

resume

def link_plugin(name)
  exec "cd /etc/munin/plugins; ln -s /usr/share/munin/plugins/#{name} #{name}"
end

 
exec "apt-get install munin munin-node -y"
exec "cd /etc/munin/; rm -f munin.conf; wget http://makevoid.dlinkddns.com:3000/config/munin/munin.conf"
exec "cd /etc/munin/plugin-conf.d; rm -f munin-node; wget http://makevoid.dlinkddns.com:3000/config/munin/munin-node"
exec "mkdir -p /www/munin"
exec "chown -R munin:munin /www/munin"

link_plugin "nginx_status"
link_plugin "nginx_request"
link_plugin "mysql_bytes"      
link_plugin "mysql_innodb"      
link_plugin "mysql_queries"     
link_plugin "mysql_slowqueries"



exec "wget http://gist.github.com/20319.txt && sudo mv 20319.txt /usr/share/munin/plugins/passenger_status && sudo chmod a+x /usr/share/munin/plugins/passenger_status && sudo ln -s /usr/share/munin/plugins/passenger_status /etc/munin/plugins/passenger_status"

exec "wget http://gist.github.com/21391.txt && sudo mv 21391.txt /usr/share/munin/plugins/passenger_memory_stats && sudo chmod a+x /usr/share/munin/plugins/passenger_memory_stats && sudo ln -s /usr/share/munin/plugins/passenger_memory_stats /etc/munin/plugins/passenger_memory_stats"



exec "restart munin-node"