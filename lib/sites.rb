require "erb"

PATH = File.expand_path "../../", __FILE__

require "#{PATH}/config/environment"

def exec(command)
  puts "executing: #{command}"
  `#{command}`.strip
end

EXTRA_VHOSTS = "
# fiveserv
# include /opt/nginx/vhosts;

# showoff like
server {
  server_name mkvd.net;
  location / {
    proxy_pass        http://localhost:3000;
    proxy_set_header  X-Real-IP  $remote_addr;
  }
}

# munin
server {
  server_name localhost;
  location /nginx_status {
    #stub_status on;
    access_log off;
    allow 127.0.0.1;
    deny all;
  }
}
"

def all_vhosts
  vhosts = ""
  SITES.each_with_index do |site, idx|
    result = VHTemplate.new(site).write_vhost
    vhosts << "#{result}\n"
  end

  vhosts << EXTRA_VHOSTS if HOST == :main
  vhosts
end

def write_vhosts
  exec "#{ssh} \"rm -f #{VHOSTS_PATH}/*\""
  exec "#{ssh} \"echo '#{all_vhosts.gsub(/[$]/, '\$')}' > #{VHOSTS_PATH}/all\""
end

require "#{PATH}/lib/checker"
include SiteCheck


HOST = :main
HOST = :taxi
# HOST = :uc

def ssh
  current_host = case HOST
    when :main then "makevoid.com"
    when :taxi then "taxi.mkvd.net"
  end

  "ssh root@#{current_host}"
end

require "#{PATH}/config/sites/#{HOST}"


# main

if ARGV[0] == "test"
  puts all_vhosts
else
 # exit
  write_vhosts
  exec "#{ssh} service nginx reload"
  puts "done"
  sleep 1
  check_sites
end

#exec "#{ssh} service nginx restart"
