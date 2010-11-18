module Executable
  def exec(cmd)
    puts "executing: #{cmd}"
    `#{cmd}`
  end
end