module Executable
  def exec(cmd)
    puts "executing: #{cmd}"
    `#{cmd}`
  end
end
include Executable


exec "apt-get install git-core vim -y"
exec "apt-get install httperf -y"

raise "Run dpkg-reconfigure tzdata manually"
exec "dpkg-reconfigure tzdata"
exec "apt-get install ntp"
exec "ntpdate ntp.ubuntu.com" # Update time

# apt-get install git-core vim -y
# apt-get install httperf -y