HOST = "root@makevoid.com"

class Mysql

  require_relative "utils"
  include Utils

  def initialize

  end


  def all
    dbs = mysql "-e 'show databases;'"
    dbs.split("\n") - ["Database", "information_schema", "mysql"]
  end

  def dump_all
    ssh "mkdir -p #{Utils::DUMPS_DIR}"
    all.each do |db|
      mysqldump db
    end
    ssh "cd /tmp; tar cvfz mysql_dumps.tgz mysql_dumps"
  end

  def backup_all
    t = Time.now
    s3_put "/tmp/mysql_dumps_#{t.year}_#{t.month}_#{t.day}.tgz", :mkvdumps
  end

  private

end

my = Mysql.new
my.setup_s3
my.dump_all
my.backup_all