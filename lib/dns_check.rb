path = File.expand_path "../../", __FILE__

require "#{path}/lib/utils"

IPS = {
  new: "176.31.248.215",
  old: "94.23.210.6"
}

require "#{path}/config/sites/new"

class DNSCheck
  include Utils

  def domains
    SITES.map{ |name, site| site[:domains].first  }
  end

  def start
    domains.each do |  domain|
      server = nil
      # server = "@ns19.ovh.net"
      ip = exec("dig #{server} #{domain} +short").strip

      IPS.each do |name, ip_value|
        puts name if ip == ip_value
      end
      puts
    end
  end
end

DNSCheck.new.start