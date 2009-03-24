LimeChat::Plugin.define do
  attr_reader :rules
  
  def initialize
    @rules = []
  end
  
  command_options :ignore,
    :pattern => "Matches if the message includes the given pattern."
  
  command :ignore do |message|
    @rules << { :nick => message }
  end
end