# HTTPerf tests


# httperf --server asd.com --port 80 --uri /test.html --rate 150 --num-conn 27000 --num-call 1

SERVERS = %w(makevoid.com vms.makevoid.com figurone.makevoid.com)

def exec(command)
  puts "executing: #{command}"
  puts `#{command}`.strip
end

def ssh(cmd)
  server = "figurone.makevoid.com"
  exec "ssh deploy@#{server} #{cmd}"
end

require 'uri'
def httperf(url, conns=10)
  url = URI.parse("http://#{url}")
  path = url.path == '' ? "/" : url.path 
  "httperf --server #{url.host} --port 80 --uri #{path} --rate 150 --num-conn 100 --num-call 5"
end


#ssh httperf("uploads.makevoid.com")
ssh httperf("vms.makevoid.com")

# httperf --client=0/1 --server=uploads.makevoid.com --port=80 --uri=/ --rate=150 --send-buffer=4096 --recv-buffer=16384 --num-conns=100 --num-calls=5
# Maximum connect burst length: 1
# 
# Total: connections 100 requests 500 replies 500 test-duration 1.249 s
# 
# Connection rate: 80.1 conn/s (12.5 ms/conn, <=85 concurrent connections)
# Connection time [ms]: min 535.5 avg 563.4 max 626.2 median 555.5 stddev 24.9
# Connection time [ms]: connect 93.8
# Connection length [replies/conn]: 5.000
# 
# Request rate: 400.3 req/s (2.5 ms/req)
# Request size [B]: 73.0
# 
# Reply rate [replies/s]: min 0.0 avg 0.0 max 0.0 stddev 0.0 (0 samples)
# Reply time [ms]: response 93.9 transfer 0.0
# Reply size [B]: header 215.0 content 33.0 footer 0.0 (total 248.0)
# Reply status: 1xx=0 2xx=500 3xx=0 4xx=0 5xx=0
# 
# CPU time [s]: user 0.18 system 1.03 (user 14.5% system 82.4% total 96.8%)
# Net I/O: 125.5 KB/s (1.0*10^6 bps)
# 
# Errors: total 0 client-timo 0 socket-timo 0 connrefused 0 connreset 0
# Errors: fd-unavail 0 addrunavail 0 ftab-full 0 other 0