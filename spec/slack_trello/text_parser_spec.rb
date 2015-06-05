require 'spec_helper'

module SlackTrello; describe TextParser do

  let(:dummy) do
    (Class.new do
      include TextParser

      def text
        "(well) This went swimmingly"
      end
    end).new
  end

  context "#args" do
    it "returns the arguments" do
      expect(dummy.args).to eq ["well"]
    end
  end

  context "#text_message" do
    it "returns the message" do
      expect(dummy.text_message).to eq "This went swimmingly"
    end
  end

  context "valid_text_format?" do
    it "returns true if the format is valid" do
      expect(dummy.valid_text_format?).to eq true
    end

    it "returns false if the format is not valid" do
      stupid_dummy = (Class.new do
        include TextParser

        def text
          "not valid"
        end
      end).new
      expect(stupid_dummy.valid_text_format?).to eq false
    end
  end

end; end

