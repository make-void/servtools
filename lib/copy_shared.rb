path = File.expand_path "../../", __FILE__
PATH = path
HOST = "root@makevoid.com"

require 'json'

class Shared

  @@config = :main
  require "#{PATH}/config/sites/#{@@config}"
  require_relative "utils"
  include Utils


  def initialize
    @dirs = {}
  end

  def fetch_dirs
    SITES.each do |name, site|
      puts name
      out = ssh "ls /www/#{name}/shared 2>&1"
      if out =~ /No such file or directory/
        # puts "skip"
      else
        results = out.split("\n")
        results -= %w(bundle cached-copy log pids system)
        if results != []
          @dirs[name] = results
          puts results
        end
      end
      puts
    end
  end

  def copy
    cache_file = "#{PATH}/tmp/shareds_cache.json"
    unless File.exist? cache_file
      fetch_dirs
      File.open(cache_file, "w"){ |f| f.write @dirs.to_json }
    else
      @dirs = JSON.parse File.open(cache_file).read
    end

    @dirs.each do |name, dirs|
      dirs.each do |dir|
        next if File.extname(dir) == ".tgz"
        puts "# #{dir}"
        ssh "cd /www/#{name}/shared; tar cvfz #{dir}.tgz #{dir}"
        file = "/www/#{name}/shared/#{dir}.tgz"
        s3_put file, "mkvlogs/shareds/"
        ssh "rm -f #{file}"
        puts
      end
    end

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