require File.expand_path('../test_helper', __FILE__)
require File.expand_path('../../lib/ignore', __FILE__)

describe 'Ignore' do
  it "should have registered the `ignore' command" do
    plugin.should.not.be nil
  end
  
  it "should add a nick ignore rule" do
    LimeChat::Plugin.process_command(:ignore, 'alloy')
    plugin.rules.should.include(:nick => 'alloy')
  end
  
  private
  
  def plugin
    LimeChat::Plugin.all.find { |p| p.respond_to?(:ignore_command) }
  end
end
