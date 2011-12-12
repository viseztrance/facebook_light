require "base64"
require "openssl"
require "cocaine"
require "facebook_light/version"
require "facebook_light/request"
require "facebook_light/client"

module FacebookLight

  def self.settings
    @@settings ||= {
      :site => "https://graph.facebook.com"
    }
  end

  def self.settings=(settings)
    @@settings = settings
  end

end
