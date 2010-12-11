#!/usr/bin/env ruby

# USAGE:
# ruby < <( curl http://makevoid.dlinkddns.com:3000/instance.rb )
# 
# note: read SETUP if you haven't read it yet

path = File.expand_path "../", __FILE__
#require "lib/executable"
module Executable
  def exec(cmd)
    unless @skip
      puts "executing: #{cmd}"
      `#{cmd}`
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


exec "passenger-install-nginx-module"
# MANUAL - select option 1 with default options (installs nginx)



exec "cd ~/tmp"
exec "git clone git://github.com/jnstq/rails-nginx-passenger-ubuntu.git"
exec "mv rails-nginx-passenger-ubuntu/nginx/nginx /etc/init.d/nginx"
exec "chown root:root /etc/init.d/nginx"

exec "/usr/sbin/update-rc.d -f nginx defaults"
# update-rc.d -f apache2 remove


resume

exec "mkdir -p ~/tmp"
exec "cd ~/tmp; git clone git://github.com/makevoid/vmserver.git"
exec "cp ~/tmp/vmserver/config/box/nginx.conf /opt/nginx/nginx.conf" 

puts "finished!"
