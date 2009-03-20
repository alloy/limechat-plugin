LimeChat::Plugin.define do
  attr_reader :nicks
  
  def initialize
    @nicks = []
  end
  
  command :ignore do |message|
    @nicks << message
  end
end