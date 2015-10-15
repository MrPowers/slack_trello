require 'spec_helper'

module SlackTrello; module SlackHelpers; describe ResponseParser do

  let(:parser) do
    args = {
      "token" => "gIkuvaNzQIHg97ATvDxqgjtO",
      "team_id" => "T0001",
      "team_domain" => "example",
      "channel_id" => "C2147483705",
      "channel_name" => "test",
      "user_id" => "U2147483697",
      "user_name" => "Steve",
      "command" => "/weather",
      "text" => "94070"
    }
    ResponseParser.new(args)
  end

  context "#token" do
    it "returns the token" do
      expect(parser.token).to eq "gIkuvaNzQIHg97ATvDxqgjtO"
    end
  end

  context "#user_name" do
    it "returns the user_name" do
      expect(parser.user_name).to eq "Steve"
    end
  end

  context "#method_missing" do
    it "raises an exception when the method name doesn't correspond with a key in the args hash" do
      expect{
        parser.blah
      }.to raise_error NoMethodError
    end
  end

end; end; end

