path = File.expand_path "../../", __FILE__
PATH = path

class Shared

  HOST = :new
  require "#{PATH}/config/sites/#{HOST}"
  require "#{PATH}/lib/utils"
  
  
  def initialize
    @from = "old.makevoid.com" # from
    @to = "new.makevoid.com" # to
  end

  def copy
    SITES.each do |name, site|
      name
    end
    
    
    # SITES
    # dirs = sites.map :dir
    # zipfile = tar :antani, ["aa", "bb"]
    # scp zipfile, @to

    # zip
  end
  
  private
  
  def tar(name, *files)
    puts "TODO: move in utils"
    puts files.flatten.inspect
    "path/#{name}.tgz"
  end




end

shr = Shared.new
shr.copy