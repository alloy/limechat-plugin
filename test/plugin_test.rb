require File.expand_path('../test_helper', __FILE__)

LimeChat::Plugin.define do
  command :test do |message|
    an_instance_method(message)
  end
  
  def an_instance_method(message)
    'Hey there' if message == 'Howdy'
  end
end

describe "LimeChat::Plugin class" do
  it "should define a LimeChat::Plugin subclass" do
    before = plugin.all.length
    plugin.define { def foo; end }
    
    plugin.all.length.should == before + 1
    plugin.all.last.should.respond_to :foo
  end
  
  it "should forward the command to the plugin" do
    plugin.process_command(:test, 'Howdy').should == 'Hey there'
  end
  
  it "should return nil if a not existing command is processed" do
    plugin.process_command(:does_not_exist, 'Whatever').should.be nil
  end
  
  private
  
  def plugin
    LimeChat::Plugin
  end
end

describe "LimeChat::Plugin instance" do
  it "should define an instance method for the given block" do
    instance.test_command('Howdy').should == 'Hey there'
  end
  
  private
  
  def instance
    LimeChat::Plugin.plugins.first
  end
end