require 'net/http'

class LibUp

  LIBS = [
    {
      name: "jquery",
      files: ["jquery.js"],
      version_str: "jQuery v1.7 jquery.com",
      url: "http://code.jquery.com/jquery.min.js"
    },
    # underscore
    # backbone
    # coffeescript
    # haml-js, sass-js
    # zepto
    # jquery-ui (hard)
  ]

  def initialize
    @dir = File.expand_path "~/Sites"
    @sites = Dir.glob "#{@dir}/*/"
  end


  def check_versions
    LIBS.each do |lib|
      lib[:founds] = []
      founds = lib[:files].each do |file|
        # ext = File.basename file
        @sites.each do |site|
          files = Dir.glob "#{site}**/#{file}"
          files.each do |f|
            # cont = File.read(f)
            # match = cont.match lib[:version_str]
            # match = cont.match lib[:regex]
            lib[:founds] << f# if match
          end
        end
      end
    end

    # download and write libs

    LIBS.each do |lib|
      uri = URI.parse lib[:url]
      updated_lib = Net::HTTP.get_response(uri).body

      lib[:founds].each do |path|
        # old = File.read path
        puts path.split("/")[4]
        File.open(path, "w") do |file|
          file.write updated_lib
        end
      end
    end
  end

end

lu = LibUp.new
lu.check_versions