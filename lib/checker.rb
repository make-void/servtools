# note: took from pingaholic

# @page = Page.new(name: "pp", url: "pietroporcinai.net")
# @checker = Checker.new(@page)
# @checker.execute
# @checker.status

class Page 
  attr_accessor :name, :url, :match
  def initialize(values)
    @name = values[:name]
    @url = "http://#{values[:url]}"
    @match = values[:match]
  end
end

require 'net/http'

class Checker
  def initialize(page)
    @page = page
    @url = page.url
    @match = page.match
    @redirects = []
  end
  
  attr_accessor :response
  attr_reader :page
    
  def execute(url=@url)
    self.response = execute_rescuing(url)
    
    if response.kind_of?(Exception)  
      @status = "FAIL: { error: { message: '#{response.message}' }, page: { url: '#{page.url}', match: '#{page.match}' } }"
      return
    end
      
    if response.kind_of?(Net::HTTPRedirection)  
      @redirects << redirect_url
      execute redirect_url
      return
    end
    
    match_response
  end
    
  def status
    @status ||=  @down ? "DOWN" : "UP"
  end
  
  def down?
    @down
  end
  
  private

  def execute_rescuing(url)
    begin
      Net::HTTP.get_response(URI.parse(url))
    rescue Errno::ECONNREFUSED => err
      err
    end
  end

  def notify
    @down = true
    # puts "Preparing to send a DOWN notification"
    # puts "#{@url} - #{@redirects}"
    # #puts response.body
    # #Notifier.deliver_page_notification(@page)
    # puts "DOWN notification sent!"
  end
  
  def match_response
    match = response.body =~ /#{@match}/
    #puts "#{match.inspect}"
    if match.nil?
      notify
    end
  end
  
  def redirect_url
    if response['location'].nil?
      response.body.match(/<a href=\"([^>]+)\">/i)[1]
    else
      response['location']
    end
  end
  
end
