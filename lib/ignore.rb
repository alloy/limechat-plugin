LimeChat::Plugin.define do
  attr_reader :rules
  
  def initialize
    @rules = []
  end
  
  command :ignore do |message|
    @rules << { :nick => message }
  end
end