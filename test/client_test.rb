require "test/unit"
require File.expand_path("../lib/facebook_light", File.dirname(__FILE__))

class RequestTest < Test::Unit::TestCase

  include FacebookLight

  def test_url_access_token_addition
    client = Client.new("mytoken")
    url1 = "http://api.fb.com"
    assert_equal "http://api.fb.com?access_token=mytoken", client.send(:append_access_token, url1)

    url2 = "http://api.fb.com?param1=val1"
    assert_equal "http://api.fb.com?param1=val1&access_token=mytoken", client.send(:append_access_token, url2)
  end

end
