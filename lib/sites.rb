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

# munin
server {
  server_name localhost;
  location /nginx_status {
    #stub_status on;
    access_log off;
    allow 127.0.0.1;
    deny all;
  }   
}"

def write_vhosts
  exec("#{ssh} \"rm -f #{VHOSTS_PATH}/*\"")
  
  all_vhosts = ""
  SITES.each_with_index do |site, idx|
    result = VHTemplate.new(site).write_vhost 
    all_vhosts << "#{result}\n"
  end
  
  all_vhosts << EXTRA_VHOSTS if HOST == :new
  
  #idx = idx.to_s.size == 1 ? "0#{idx}" : idx
  #puts "#{name} #{confs} #{idx}"
  exec "#{ssh} \"echo '#{all_vhosts.gsub(/[$]/, '\$')}' > #{VHOSTS_PATH}/all\""
  
  # exec "#{ssh} service nginx restart"
  # sleep 1
end

require "#{PATH}/lib/checker"
include SiteCheck



HOST = :new
# HOST = :uc


def ssh
  "ssh root@#{"#{HOST}." if HOST != :default }makevoid.com"
end

require "#{PATH}/config/sites/#{HOST}"

# write_vhosts
# exec "#{ssh} service nginx restart"
puts "done"
sleep 1
check_sites
#exec "#{ssh} service nginx restart"