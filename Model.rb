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
  LIST_PROJECTS_URI = "http://localhost:3000/timeline/edit.json"
  UPDATE_PROJECT_URI = "http://localhost:3000/timeline.json"
  attr_writer :user
  attr_writer :pass

  def initialize(user = "eregontp@gmail.com", pass = "azerty")
    @user, @pass = user, pass
  end

  def projects
    uri = URI.parse(LIST_PROJECTS_URI)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request.basic_auth(@user, @pass)
    response = http.request(request)

    JSON.parse(response.body)
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
