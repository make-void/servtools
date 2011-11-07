PATH = File.expand_path("../../", __FILE__)

require "#{PATH}/config/sites/ovh"

sites_path = File.expand_path "~/Sites"
dev_path = File.expand_path "~/dev"

nonstatic_sites = SITES.map{ |a| a unless a.last[:type] == :static }.compact

def rails?
  File.exist?("#{@path}/config/application.rb")
end


def exec(cmd, print=true)
  puts "executing: #{cmd} in #{@path}" if print
  result = `cd #{@path}; #{cmd}`.strip 
  puts result if print
  result
end

def execs(cmd)
  `cd #{@path}; git status`
end

def svn?
  File.exist? "#{@path}/.svn"
end

def git?
  exec("git status", false) != ""
end

def set_deploy_domain
  deploy = "#{@path}/config/deploy.rb"
  deploy = File.read deploy
  regex = /set :domain,\s+"([\w.]+)"/
  match = deploy.match regex
  if match
    domain = match[1] 
    print " - domain: #{domain}"
    unless domain == new_domain
      puts "\nchanging domain to: #{new_domain}"
      file = deploy.sub regex, "set :domain, \"#{new_domain}\" # old: #{domain}"
      File.open(deploy, "w"){ |f| f.write f }
    end
  else
    puts "\ndomain not found!"
  end
end

nonstatic_sites.each do |name, site|
  #puts name
  path = "#{sites_path}/#{name}"
  if !File.exists?(path) 
    path = "#{dev_path}/#{name}"
  end

  @path = path
  
  print @path
  if rails?
    print " - rails"
    
    if git?
      # exec "git status"
      # exec "cap deploy"
    end
    
    if svn?
      #exec "svn add lib/annotated_logger.rb"
      # exec "svn status"
      # exec "svn commit -m ''"
      # exec "cap deploy"
    end
    
  end
  
  unless rails?
    print " - non-rails"
    print ">> no deploy found" unless File.exists? "#{@path}/config/deploy.rb"
  end
  
  
  if git?
    print " - git"
    status = execs "git status"
    unless status =~ /nothing to commit \(working directory clean\)/
      puts status
    end
  end
  
  if svn?
    print " - svn"
  end
  
  
  domain = "kim.makevoid.com"
  # set_deploy_domain domain
  
  
  puts
  
  #exit
  
  
end