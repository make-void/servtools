#!/usr/bin/env ruby

# USAGE:
# ruby < <( curl http://makevoid.dlinkddns.com:3000/instance.rb )

path = File.expand_path "../", __FILE__
#require "lib/executable"
module Executable
  def exec(cmd)
    puts "executing: #{cmd}"
    `#{cmd}`
  end
end
include Executable

exec "mkdir -p ~/tmp"

exec "cd ~/tmp"
exec "git clone git://github.com/jnstq/rails-nginx-passenger-ubuntu.git"
exec "mv rails-nginx-passenger-ubuntu/nginx/nginx /etc/init.d/nginx"
exec "chown root:root /etc/init.d/nginx"

exec "/usr/sbin/update-rc.d -f nginx defaults"
# update-rc.d -f apache2 remove

exec "apt-get remove ruby"