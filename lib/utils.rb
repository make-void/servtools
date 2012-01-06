module Utils
  
  DUMPS_DIR = "/tmp/mysql_dumps"
  PASS = File.read(File.expand_path "~/.password").strip
  
  def exec(cmd)
    puts "executing: #{cmd}"
    res = `#{cmd}`
    puts res
    res
  end
  
  def exists?(file)
    result = ssh "ls #{file} 2>&1"
    result !~ /No such file or directory/
  end
  
  def ssh(cmd)
    exec "ssh #{HOST} \"#{cmd}\""
  end
  
  def scp(file, dest)
    exec "scp #{file} #{HOST}:#{dest}"
  end
  
  def mysql(cmd)
    ssh "mysql -u root --password=#{PASS} #{cmd}"
  end
  
  def mysqldump(db)
    ssh "time mysqldump -u root --password=#{PASS} #{db} > #{DUMPS_DIR}/#{db}.sql"
  end
  
  
  def setup_s3
    remote_conf = "/root/.s3cfg"
    unless exists? remote_conf
      puts "Installing and configuring s3cfg"
      scp "/Users/makevoid/.s3cfg", remote_conf
      ssh "apt-get install s3cmd -y"
    end
    # ssh "cat /root/.s3cfg"
  end
  
end