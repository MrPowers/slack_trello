module SlackTrello; class Speaker

  def initialize(args)
    @webhook_url = args.fetch(:webhook_url)
    @channel = args.fetch(:channel)
    @username = args.fetch(:username, "notifier")
  end

  def speak(msg)
    @session.ping msg, icon_emoji: ":mdb:"
  end

  private

  def session
    @session ||= Slack::Notifier.new(@token, channel: @channel,  username: @username)
  end

end; end
