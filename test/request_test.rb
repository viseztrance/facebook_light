require "test/unit"
require File.expand_path("../lib/facebook_light", File.dirname(__FILE__))

class RequestTest < Test::Unit::TestCase

  TEST_SERVER_URL = "http://localhost:9900"

  include FacebookLight

  def test_get_method
    response = Request.new(TEST_SERVER_URL, :method => "GET").run
    assert_equal "GET", JSON.parse(response)["REQUEST_METHOD"]
  end

  def test_post_method
    response = Request.new(TEST_SERVER_URL, :method => "POST").run
    assert_equal "POST", JSON.parse(response)["REQUEST_METHOD"]
  end

  def test_as_json_response
    response = Request.new(TEST_SERVER_URL, :method => "GET").run
    assert_equal "GET", response.as_json[:REQUEST_METHOD]
  end

  def test_get_params
    response = Request.new(File.join(TEST_SERVER_URL, "?p1=r1&p2=r2"), :method => "GET").run
    assert_equal ({ "p1" => "r1", "p2" => "r2" }), JSON.parse(response)["rack.request.query_hash"]
  end

  def test_post_params
    response = Request.new(TEST_SERVER_URL, :method => "POST", :params => { "p1" => "r1", "p2" => "r2" }).run
    assert_equal ({ "p1" => "r1", "p2" => "r2" }), JSON.parse(response)["rack.request.form_hash"]
  end

end
