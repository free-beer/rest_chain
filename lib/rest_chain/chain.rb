require "stringio"

module RestChain
  class Chain < Link
    DEFAULT_SCHEME             = "https".freeze

    # Constructor for the Chain class.
    #
    # ==== Parameters
    # settings::  A Hash of the settings for the chain. Currently recognised
    #             settings are...
    #              * :host        The REST API host to be interacted with, this
    #                             must be specified.
    #              * :logger      The Logger to be used in the Chain.
    #              * :parameters  A Hash of default parameters that get sent
    #                             with all requests.
    #              * :path        Either a String or an Array. If its an array
    #                             the elements will be concatentated together
    #                             into a String. This specifies common elements
    #                             of the path to avoid having to repeatedly
    #                             specify them as part of the chain.
    #              * :port        The port number to contact the REST API host
    #                             on. Need not be specified if the default port
    #                             (80 for HTTP and 443 for HTTPS) are to be used.
    #              * :scheme      Should be given a value of either "http" or "https".
    #                             This is the scheme that will be used when talking
    #                             to the REST API. Defaults to "https" if not 
    #                             explicitly specified.
    def initialize(settings={})
      super("", nil, settings[:logger])
      @host   = settings.fetch(:host, "").strip
      raise RestChainError.new("No REST API host specified when creating a chain.") if @host == ""

      @port   = settings[:port]
      @scheme = settings.fetch(:scheme, DEFAULT_SCHEME).downcase
      @path   = settings.fetch(:path, [])
      @path   = @path.split("/").delete_if {|s| s == ""} if @path.kind_of?(String)
      @parameters = {}.merge(settings.fetch(:parameters, {}))
    end

    attr_reader :host, :path, :port, :scheme

    def full_parameters(extras={})
      {}.merge(@parameters).merge(extras)
    end

    def url
      text = StringIO.new
      text << @scheme << "://" << @host
      text << ":#{@port}" if @port
      text << "/" if text.string[-1,1] != "/"
      text << "#{@path.join('/')}"
      text.string
    end
  end
end
