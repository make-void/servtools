HOST = "root@new.makevoid.com"

PATH = File.expand_path("../../", __FILE__)

require "#{PATH}/config/sites/ovh"

sites_path = File.expand_path "~/Sites"
dev_path = File.expand_path "~/dev"

nonstatic_sites = SITES.map{ |a| a unless a.last[:type] == :static }.compact

def rails?
  File.exist?("#{@path}/config/application.rb")
end

require_relative "utils"
include Utils

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

def set_deploy_domain(new_domain)
  path = "#{@path}/config/deploy.rb"
  deploy = File.read path
  regex = /set :domain,\s+"([\w.]+)"/
  match = deploy.match regex
  if match
    domain = match[1] 
    print " - domain: #{domain}"
    unless domain == new_domain
      puts "\nchanging domain to: #{new_domain}"
      file = deploy.sub regex, "set :domain, \"#{new_domain}\" # old: #{domain}"
      File.open(path, "w"){ |f| f.write file }
    end
  else
    puts "\ndomain not found!"
  end
end

def set_deploy_svn(new_svn)
  path = "#{@path}/config/deploy.rb"
  deploy = File.read path
  # set :repository,  "svn://#{domain}
  regex = /set :repository,\s+"svn:\/\/(.+?)\//
  match = deploy.match regex
  puts
  p match
  puts "--"
  # puts deploy
  # exit
  if match
    repo = match[1] 
    print " - svn: #{repo}"
    unless repo == new_svn
      puts "\nchanging svn to: #{new_svn}"
      file = deploy.sub regex, "set :repository,  \"svn://#{new_svn}/"
      File.open(path, "w"){ |f| f.write file }
    end
  else
    puts "\ndomain not found!"
  end
end

ssh "apt-get install subversion -y"

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
  else
    print " - svn"
    exec "svn status"
  end
  
  
  domain = "kim.makevoid.com"
  set_deploy_domain domain
  
  svn_domain = "makevoid.com"
  if svn?
    set_deploy_svn svn_domain
    # exit
  end

  
  exec "cap deploy:setup"
  dep = exec "cap deploy 2>&1"
  
  if dep =~ /fail/
    puts "exiting because of a failed deploy"
    exit 
  end
  

  puts "-" * 80
  
  #exit
  
  
end