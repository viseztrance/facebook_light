module FacebookLight

  class Client

    attr_accessor :access_token

    class << self

      def authorize_url(options = {})
        redirect_uri = options[:redirect_uri] || raise("Redirect URI must be specified")
        scope = options[:scope] || "email"
        url = "https://www.facebook.com/dialog/oauth?client_id=%s&redirect_uri=%s&scope=%s" %
          [FacebookLight.settings[:app_id], redirect_uri, scope]
      end

      def get_access_token(code, redirect_uri)
        url = "https://graph.facebook.com/oauth/access_token?client_id=%s&redirect_uri=%s&client_secret=%s&code=%s" %
          [FacebookLight.settings[:app_id], redirect_uri, FacebookLight.settings[:app_secret], code]
        token = CGI.parse(Request.new(url).run)["access_token"].first
        new token
      end

      def parse_signed_request(code)
        base64_url_decode = lambda { |value|
          value += "=" * (4 - value.length.modulo(4))
          Base64.decode64(value.tr("-_", "+/"))
        }
        # Facebook's signed requests come in two parts - the signature and the data payload
        # see http://developers.facebook.com/docs/authentication/canvas
        encoded_sig, payload = code.split(".")
        sig = base64_url_decode.call(encoded_sig)

        # If the signature matches, return the data, decoded and parsed as JSON.
        if OpenSSL::HMAC.digest("sha256", FacebookLight.settings[:app_secret], payload) == sig
          token = JSON.parse(base64_url_decode.call(payload))["oauth_token"]
          new token
        else
          nil
        end
      end

    end

    def initialize(access_token)
      self.access_token = access_token
    end

    def get(query, options = {})
      host = options[:site] || FacebookLight.settings[:site]
      url = "#{host}#{query}?access_token=#{access_token}"
      JSON.parse(Request.new(url).run).with_indifferent_access
    end

  end

end
