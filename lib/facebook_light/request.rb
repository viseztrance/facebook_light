module FacebookLight

  class Request

    attr_accessor :dispatcher, :command

    def initialize(url, options = {})
      args = {
        :timeout => "2",
        :retries => "3",
        :method  => options[:method] || "GET",
        :url     => url,
        :params  => parameterize(options[:params])
      }
      self.dispatcher = Cocaine::CommandLine.new("curl", "-X :method --connect-timeout :timeout --retry :retries :url --data :params", args)
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
      (data || {}).map { |k, v| "#{k}=#{v}" }.join("&")
    end

  end

end
