require 'spec_helper'

module SlackTrello; describe TextParser do

  let(:parser) { TextParser.new("(this is) some text") }

  context "#args" do
    it "returns the arguments" do
      expect(parser.args).to eq ["this", "is"]
    end
  end

  context "#text_message" do
    it "returns the message" do
      expect(parser.text_message).to eq "some text"
    end
  end

  context "valid_text_format?" do
    it "returns true if the format is valid" do
      expect(parser.valid_text_format?).to eq true
    end

    it "returns false if the format is not valid" do
      parser = TextParser.new("some text")
      expect(parser.valid_text_format?).to eq false
    end
  end

end; end

