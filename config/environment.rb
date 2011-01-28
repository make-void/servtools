
VHOSTS_PATH = "/opt/nginx/vhosts"
VHOST_TEMPLATE = File.read("#{PATH}/config/nginx_vhost.erb")

class VHTemplate
  def initialize(site)
    @site = site
  end
  
  def write_vhost
    name, conf = @site.each{ |k, v| [k, v] }
    conf[:type] = :rack if conf[:type].nil?
    template = ERB.new VHOST_TEMPLATE
    result = template.result(binding)
  end
end