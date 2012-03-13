module FacebookLight

  class Request

    attr_accessor :dispatcher, :command

    def initialize(url, options = {})
      params = parameterize(options[:params])
      args = {
        :timeout => "2",
        :retries => "3",
        :method  => options[:method] || "GET",
        :url     => url,
        :params  => params
      }
      self.dispatcher = Cocaine::CommandLine.new("curl", "-X :method --connect-timeout :timeout --retry :retries :url #{params}", args)
    end

    def run
      response = self.dispatcher.run
      def response.as_json
        result = JSON.parse(self)
        result.is_a?(Array) ? result.map(&:with_indifferent_access) : result.with_indifferent_access
      end
      response
    end

    private

    # Builds a query string from the received +Hash+.
    def parameterize(data)
      return unless data
      data.map do |k, v| 
        if v.is_a?(Hash)
          value = "@#{v[:path]}"
          "--form %s=%s" % [k, quote(value)]
        else
          "--form-string %s=%s" % [k, quote(v)]
        end
      end.join(" ")
    end
    
    def quote(string)
      string.split("'").map{ |m| "'#{m}'" }.join("\\'")
    end

  end

end
