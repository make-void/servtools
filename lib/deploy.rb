PATH = File.expand_path("../../", __FILE__)

require "#{PATH}/config/sites_ovh"

sites_path = File.expand_path "~/Sites"
dev_path = File.expand_path "~/dev"

nonstatic_sites = SITES.map{ |a| a unless a.last[:type] == :static }.compact

def rails?(path)
  File.exist?("#{path}/config/application.rb")
end


def exec(cmd, print=true)
  puts "executing: #{cmd} in #{@path}" if print
  result = `cd #{@path}; #{cmd}`.strip 
  puts result if print
  result
end

def svn?
  File.exist? "#{@path}/.svn"
end

def git?
  exec("git status", false) != ""
end

nonstatic_sites.each do |name, site|
  #puts name
  path = "#{sites_path}/#{name}"
  if !File.exists?(path) 
    path = "#{dev_path}/#{name}"
  end

  if rails?(path)
    # `mate #{path}/config/application.rb`
    # `mate #{path}/lib/annotated_logger.rb`
    @path = path
    puts path
    #puts git?(path)
    puts svn? && git?
    if git?
      #exec "git add config/application.rb lib/annotated_logger.rb"
      exec "git status"
      # exec "cap deploy"
    end
    
    if svn?
      #exec "svn add lib/annotated_logger.rb"
      # exec "svn status"
      # exec "svn commit -m ''"
      # exec "cap deploy"
    end
      
    puts "-"*80
  end
  
  #exit
  
  
end