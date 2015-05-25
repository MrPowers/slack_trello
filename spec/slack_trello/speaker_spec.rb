require 'spec_helper'

module SlackTrello; describe Speaker do

  let(:speaker) do
    args = {
      webhook_url: "url",
      channel: "channel",
      username: "username"
    }
    Speaker.new(args)
  end

  context "#speak" do
    it "speaks a message in the Slack room" do
      session = double
      expect(speaker).to receive(:session).and_return session
      expect(session).to receive(:ping).with("blah blah", icon_emoji: ":mdb:")
      speaker.speak("blah blah")
    end
  end

  context "#session" do
    it "instantiates a Slack::Notifier object" do
      expect(::Slack::Notifier).to receive(:new).with("url", { channel: "#channel", username: "username" })
      speaker.send(:session)
    end
  end

  context "#channel" do
    it "prepends # when it's not prepended already" do
      expect(speaker.send(:channel)).to eq "#channel"
    end

    it "doesn't prepend # when the channel name already starts with #" do
      args = {
        webhook_url: "url",
        channel: "#blah",
        username: "username"
      }
      speaker = Speaker.new(args)
      expect(speaker.send(:channel)).to eq "#blah"
    end
  end

end; end

