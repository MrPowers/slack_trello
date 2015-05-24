module SlackTrello; class TextParser

  attr_reader :text

  def initialize(text, options = {})
    @text = text
    @required_arguments = options.fetch(:required_arguments, nil)
  end

  def args
    matched_text[1].strip.split(" ")
  end

  def text_message
    matched_text[2].strip
  end

  def valid_text_format?
    !!matched_text
  end

  private

  def regex
    /\((.+?)\)(.+)?/
  end

  def matched_text
    text.match(regex)
  end

end; end


