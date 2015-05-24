module SlackTrello; class ResponseParser

  attr_reader :args

  def initialize(args)
    @args = args
  end

  def method_missing(name)
    super unless args.has_key?(name.to_s)
    args.fetch(name.to_s)
  end

end; end
