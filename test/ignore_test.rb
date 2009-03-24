require File.expand_path('../test_helper', __FILE__)
require File.expand_path('../../lib/ignore', __FILE__)

describe 'Ignore' do
  it "should have registered the `ignore' command" do
    plugin.should.not.be nil
  end
  
  it "should add a nick ignore rule" do
    process_command(:ignore, 'alloy')
    plugin.rules.should.include(:nick => 'alloy')
  end
  
  it "should add a pattern ignore rule" do
    process_command(:ignore, '--pattern "foo bar"')
    plugin.rules.should.include(:pattern => 'foo bar')
  end
  
  private
  
  def process_command(command, message)
    LimeChat::Plugin.process_command(command, message)
  end
  
  def plugin
    LimeChat::Plugin.all.find { |p| p.respond_to?(:ignore_command) }
  end
end
