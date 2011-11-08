HOST = "root@makevoid.com"

class Mysql  
  
  
  DUMPS_DIR = "/tmp/mysql_dumps"
  
  def initialize
    
  end
  
  
  def all
    dbs = mysql "-e 'show databases;'"
    dbs.split("\n") - ["Database", "information_schema", "mysql"]
  end
  
  def dump_all
    ssh "mkdir -p #{DUMPS_DIR}"
    all.each do |db|
      mysqldump db
    end
    ssh "cd /tmp; tar cvfz mysql_dumps.tgz mysql_dumps"
  end
  
  def backup_all
    ssh "s3cmd put /tmp/mysql_dumps.tgz s3://mkvdumps"
  end
  
  private
  
  require_relative "utils"
  include Utils
end

my = Mysql.new
my.setup_s3
my.dump_all
my.backup_all