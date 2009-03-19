# Methods and simple DSL
LimeChat::Plugin.define do
  def ignore(message)
    case message
    when /\w+/
      ignore_nick(message)
    end
    false # don't send to server
  end
  command :ignore
  
  def ignore_nick(nick)
    preferences[:nicks] << nick
  end
  
  # If the +nick+ is one that should be ignored then return false which makes
  # LimeChat cancel any further processing of the +message+. If it shouldn't be
  # ignored then return true which continues the process chain.
  def receive_message(nick, message)
    !preferences[:nicks].include?(nick)
  end
end

# More complicated DSL
LimeChat::Plugin.define do
  command :ignore do |message|
    case message
    when /\w+/
      ignore_nick(message)
    end
    false # don't send to server
  end
  
  def ignore_nick(nick)
    preferences[:nicks] << nick
  end
  
  # If the +nick+ is one that should be ignored then return false which makes
  # LimeChat cancel any further processing of the +message+. If it shouldn't be
  # ignored then return true which continues the process chain.
  event :receive_message do |nick, message|
    !preferences[:nicks].include?(nick)
  end
end

# /ignore alloy