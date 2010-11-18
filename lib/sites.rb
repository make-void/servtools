require "erb"

PATH = File.expand_path "../../", __FILE__
require "#{PATH}/config/sites"

VHOSTS_PATH = "/opt/nginx/vhosts"
VHOST_TEMPLATE = File.read("#{PATH}/config/nginx_vhost.erb")

def exec(command)
  puts "executing: #{command}"
  `#{command}`.strip
end

def ssh
  "ssh root@makevoid.com"
end

def write_vhosts
  exec("#{ssh} \"rm -f #{VHOSTS_PATH}/*\"")

  SITES.each_with_index do |site, idx|
    name, conf = site.each{ |k, v| [k, v] }
    idx = idx.to_s.size == 1 ? "0#{idx}" : idx

    conf[:type] = :rack if conf[:type].nil?
    template = ERB.new VHOST_TEMPLATE
    result = template.result(binding)
    #puts "#{name} #{confs} #{idx}"
    exec "#{ssh} \"echo '#{result}' > #{VHOSTS_PATH}/#{idx}_#{name}\""
  end
end

def check_sites
  require "#{PATH}/lib/checker"
  SITES.each do |name, conf|
    unless conf[:check].nil?
      page = Page.new(name: name, url: conf[:domains].first, match: conf[:check])
      checker = Checker.new(page)
      checker.execute
      puts "#{name}: #{checker.status}"
    else
      puts "#{name} skipped"
    end
  end
end

#write_vhosts
#exec "#{ssh} service nginx restart"
check_sites