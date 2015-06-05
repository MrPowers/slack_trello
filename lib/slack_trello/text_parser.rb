module SlackTrello; module TextParser

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


