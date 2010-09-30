require "net/http"
require "uri"
require "json"

#Hack for MacRuby 0.6:
class NSString
	def force_encoding(*args)
		self
	end
end

class Model
  LIST_PROJECTS_URI = "http://belighted-88mph.heroku.com/timeline/edit.json"
  UPDATE_PROJECT_URI = "http://belighted-88mph.heroku.com/timeline.json"
  attr_writer :user
  attr_writer :pass

  def initialize(user = "", pass = "")
	@user = NSUserDefaults.standardUserDefaults['user']
	@pass = NSUserDefaults.standardUserDefaults['pass']
  end

  def projects
    uri = URI.parse(LIST_PROJECTS_URI)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(@user, @pass)
    response = http.request(request)
	if response.code != "200"
	  puts "Oops, got a suspicious response code: #{response.code}"
	  {}
	else
	  JSON.parse(response.body)
	end
  end
  
  def update_project(name)
    uri = URI.parse(UPDATE_PROJECT_URI)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.request_uri)
    
    data = {
      # "_method" => "put",
      "time_slot[project_name]" => name,
      "commit" => "Track time!"
    }

    request.set_form_data(data)
    request.basic_auth(@user, @pass)
    
    response = http.request(request)

    p response
    p response.body[0..10]
  end
end
