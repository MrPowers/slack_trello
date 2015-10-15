module SlackTrello; module SlackHelpers; module TextParser

  def args
    return "" unless valid_text_format?
    matched_text[1].strip.split(" ")
  end

  def text_message
    return "" unless valid_text_format?
    matched_text[2].strip
  end

  def valid_text_format?
    !!matched_text
  end

  def num_args
    args.length
  end

  private

  def regex
    /\((.+?)\)(.+)?/
  end

  def matched_text
    text.match(regex)
  end

  def text
    slack_post_response.text
  end

end; end; end

