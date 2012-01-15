require "base64"
require "openssl"
require "cocaine"
require "json"
require "active_support/core_ext/hash"
require "facebook_light/version"
require "facebook_light/request"
require "facebook_light/client"

module FacebookLight

  API_URL   = "https://api.facebook.com"
  GRAPH_URL = "https://graph.facebook.com"

  def self.settings
    @@settings ||= {}
  end

  def self.settings=(settings)
    @@settings = settings
  end

end
