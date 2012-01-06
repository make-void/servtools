#!/usr/bin/env ruby

# PingProxy API with average ping value
#
# usage:
#
#   ruby pingproxy.rb makevoid.com

require 'net/http'
require 'nokogiri'

DEBUG = false # false
DOMAIN = ARGV[0] || "makevoid.com"

#http://just-ping.com/index.php?vh=makevoid.com

#api/pingproxy.php?host=makevoid.com&cp=95.140.33.161&now=1320604299&mac=7855b1af786bf9682b403f0a6d70960d

HOST = "http://just-ping.com"

def get_page 
  uri = URI.parse "#{HOST}/index.php?vh=#{DOMAIN}"
  page = Net::HTTP.get_response uri
  body = page.body
end

# get_page

path = File.expand_path "../../", __FILE__
tmp_file = "#{path}/tmp/pingproxy.html"

body = unless DEBUG
  get_page
else
  if File.exist? tmp_file
    File.read tmp_file
  else
    body = get_page
    File.open(tmp_file, "w"){ |f| f.write body }
    body
  end
end

page = Nokogiri::HTML body

countries = []
page.search("table tr")[1..-1].each do |tr|
  countries << tr.search("td")[0].inner_text
end

# exit


urls = page.inner_text.scan(/\'api\/pingproxy\.php\?host=(.+?)\'/).map{ |s| s.first }
urls = urls.map{ |u| "#{HOST}/api/pingproxy.php?host=#{u}" }

Thread.abort_on_exception = true

threads = []
avgs = []
urls.each_with_index do |url, idx|
  threads << Thread.new do |t|
    uri = URI.parse url
    page = Net::HTTP.get_response uri
    ping = page.body
    # Okay:;684.9:;689.6:;691.4:;94.23.210.6
    _, result, min, avg, max, ip = ping.split(";")
    avgs << avg.to_f unless avg.to_f == 0.0
    puts "#{countries[idx]} #{avg.to_f}"
    unless avgs.size == 0
      sum = avgs.inject(0){ |a, v| a + v } / avgs.size 
    end
    puts "AVGS: #{sum.to_f}"
  end
end

threads.each{ |t| t.join }

