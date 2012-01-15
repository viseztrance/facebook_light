require "rubygems"
require "sinatra"
require "json"

set :logging, false
set :port, 9900

%w(get post delete).each do |method|
  send(method, "/**") do
    request.env.merge!(:body => request.body.read).to_json
  end
end
