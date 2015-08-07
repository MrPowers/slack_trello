module SlackTrello; class Speaker

  def initialize(args)
    @webhook_url = args.fetch(:webhook_url)
    @channel = args.fetch(:channel)
    @username = args.fetch(:username, "notifier")
  end

  def speak(msg)
    session.ping msg, icon_emoji: ":ghost:"
  end

  private

  def session
    @session ||= Slack::Notifier.new(@webhook_url, channel: channel, username: @username)
  end

  def channel
    @channel.start_with?("#") ? @channel : "##{@channel}"
  end

end; end
