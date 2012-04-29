path = File.expand_path "../../", __FILE__

AUTH = "root@makevoid.com"

def ssh(cmd)
  exec "ssh #{AUTH} #{cmd}"
end

def scp(file, path)
  name = File.basename file
  exec "scp #{file} #{AUTH}:#{path}/#{name}"
end


scp "config/nginx.conf", "/opt/nginx/conf"
