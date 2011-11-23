module FacebookLight

  class Request

    attr_accessor :dispatcher, :command

    def initialize(url, options = {})
      args = {
        :timeout => "2",
        :retries => "3",
        :method  => "GET",
        :url     => url
      }
      self.dispatcher = Cocaine::CommandLine.new("curl", "-X :method --connect-timeout :timeout --retry :retries :url", args)
    end

    def run
      self.dispatcher.run
    end

  end

end
