require "erb"

PATH = File.expand_path "../../", __FILE__
require "#{PATH}/config/sites"

require "#{PATH}/config/environment"

include VHTemplate

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
    result = write_vhost site
    idx = idx.to_s.size == 1 ? "0#{idx}" : idx
    #puts "#{name} #{confs} #{idx}"
    exec "#{ssh} \"echo '#{result.gsub(/[$]/, '\$')}' > #{VHOSTS_PATH}/#{idx}_#{site.first}\""
  end
  
  sleep 2
  exec "#{ssh} service nginx restart"
  sleep 1
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