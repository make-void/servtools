HOST = "root@new.makevoid.com"


class Mysqlr
    
  def ls(folder)
    files = ssh "ls #{folder}"
    files.split("\n")
  end  
    
  def restore
    # ssh "cd /tmp; s3cmd get s3://mkvdumps/mysql_dumps.tgz --force"
    # ssh "cd /tmp; tar xvfz mysql_dumps.tgz"
    
    files = ls "/tmp/mysql_dumps"
    files = files.map{ |f| f.gsub /\.sql$/, '' }
    files.each do |file|
      # restore
      
      mysql "-e 'create database if not exists #{file}'"
      mysql "#{file} < /tmp/mysql_dumps/#{file}.sql"

    end
    
  end
  
  private
  
  require_relative 'utils'
  include Utils
  
end

myr = Mysqlr.new
# myr.setup_s3
myr.restore