module Support; module Helpers

  def slack_args
    {
      "token" => "gIkuvaNzQIHg97ATvDxqgjtO",
      "team_id" => "T0001",
      "team_domain" => "example",
      "channel_id" => "C2147483705",
      "channel_name" => "test",
      "user_id" => "U2147483697",
      "user_name" => "Steve",
      "command" => "/some_command",
      "text" => "(some_arg another_arg) some stuff blah"
    }
  end

end; end

