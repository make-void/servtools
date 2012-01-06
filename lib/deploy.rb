# encoding: utf-8
Encoding.default_external = Encoding::UTF_8

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
  result = ""
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
    puts " - domain: #{domain}"
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


  if match
    repo = match[1] 
    puts " - svn: #{repo}"
    unless repo == new_svn
      puts "\nchanging svn to: #{new_svn}"
      file = deploy.sub regex, "set :repository,  \"svn://#{new_svn}/"
      File.open(path, "w"){ |f| f.write file }
    end
  else
    puts "\ndomain not found!"
  end
end

# def pre-deploy
    ssh "apt-get install subversion -y"
#   ssh "insert host to /root/.ssh/authorized_keys"
#   - github.com
#   - makevoid.com
# end

nonstatic_sites.each do |name, site|
  # next if name != :fcanessa
  next if name == :stylequiz
  # idx = SITES.keys.index name
  # next if idx < 13
  
  puts "\n\n#{"-"*80}\n#{name} (#{idx})\n#{"-"*80}\n"
  
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
    puts " - non-rails"
    puts ">> no deploy found" unless File.exists? "#{@path}/config/deploy.rb"
  end
  
  
  if git?
    puts " - git"
    status = execs "git status"
    unless status =~ /nothing to commit \(working directory clean\)/
      puts status
    end
    
    # check for this string and commit push (same for svn) 
    
    #
    #	modified:   config/deploy.rb
    #
    
  else
    puts " - svn"
    exec "svn status"
  end
  
  
  domain = "kim.makevoid.com"
  set_deploy_domain domain
  
  svn_domain = "makevoid.com"
  if svn?
    # puts ">>>>> FIX SVN: #{name}"
    # exec "mate /Users/makevoid/Sites/#{name}/config/deploy.rb"
    set_deploy_svn svn_domain
    # exit
  end
  
  puts "\nname: '#{name}'"
  # if name == :veeplay  
    exec "cap deploy:setup"
    dep = exec "cap deploy 2>&1"
  
    if dep =~ /fail|error | error|Errno/
      puts "\n\n >>> ERROR: exiting because of a failed deploy !!"
      exit 
    end
  # end
  

  # TODO: svn commit and git push etc
  
  #exit
  
  
end

# create log dir in projects
# mkdir -p log; touch log/error.log; git add .; git commit -m "added tmp dir";  git push origin master; cap deploy:setup; cap deploy
