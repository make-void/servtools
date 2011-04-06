require "erb"

PATH = File.expand_path "../../", __FILE__




require "#{PATH}/config/environment"


def exec(command)
  puts "executing: #{command}"
  `#{command}`.strip
end


  
MUNIN_VHOST = "server {
  listen 80;
  server_name localhost;
  location /nginx_status {
    stub_status on;
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
  
  #all_vhosts << MUNIN_VHOST
  
  #idx = idx.to_s.size == 1 ? "0#{idx}" : idx
  #puts "#{name} #{confs} #{idx}"
  exec "#{ssh} \"echo '#{all_vhosts.gsub(/[$]/, '\$')}' > #{VHOSTS_PATH}/all\""
  
  sleep 2
  exec "#{ssh} service nginx restart"
  sleep 1
end

def check_site(name, domain, match)
  page = Page.new(name: name, url: domain, match: match)
  checker = Checker.new(page)
  checker.execute
  puts "#{name} (#{domain}): #{checker.status}"
end

def check_sites
  require "#{PATH}/lib/checker"
  SITES.each do |name, conf|
    unless conf[:check].nil?
      [conf[:check]].flatten.each_with_index do |match, idx|
        check_site name, conf[:domains][idx], match
      end
    else
      puts "#{name} skipped"
    end
  end
end




HOSTS = {
  default: "",
  ovh: "ovh",
  sky: "sky",
  d: "d",
  # ...
}

HOST = :ovh


OVH = true
# OVH = false

def ssh
  "ssh root@#{"#{HOST}." if HOST != :default }makevoid.com"
end

require "#{PATH}/config/sites#{"_#{HOST}" if HOST != :default}"

write_vhosts
exec "#{ssh} service nginx restart"

check_sites
#exec "#{ssh} service nginx restart"