LimeChat::Plugin.define do
  attr_reader :rules
  
  def initialize
    @rules = []
  end
  
  options_for :ignore do |opts|
    opts.values [:p, :pattern] => "Matches if the message includes the given pattern."
    # opts.switches ...
  end
  
  command :ignore do |message|
    @rules << { :nick => message }
  end
end