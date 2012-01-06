path = File.expand_path "../../", __FILE__
PATH = path


# HOST = :fiveserv
HOST = :new

require "#{path}/config/sites/#{HOST}"

require "#{PATH}/lib/checker"
include SiteCheck
check_sites

check_munin
check_github
check_uploads

def check_munin
  puts "TODO: check munin"
end

def check_github
  
end

def check_uploads
  
end