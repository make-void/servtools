
VHOSTS_PATH = "/opt/nginx/vhosts"
VHOST_TEMPLATE = File.read("#{PATH}/config/nginx_vhost.erb")

module VHTemplate
  def write_vhost(site)
    name, conf = site.each{ |k, v| [k, v] }
    conf[:type] = :rack if conf[:type].nil?
    template = ERB.new VHOST_TEMPLATE
    result = template.result(binding)
  end
end