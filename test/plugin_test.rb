require File.expand_path('../test_helper', __FILE__)

LimeChat::Plugin.define do
  options_for :test do |options, result|
    options.value_options = {
      :test_option => "A test value option.",
      [:v, :value] => "A test value option with short version."
    }
    
    options.switches = {
      :test_switch => "A test switch option.",
      [:s, :switch] => "A test switch option with short version."
    }
    
    opts.on("-o", "--oldskool [VALUE]", "A test option defined with oldskool OptionParser.") do |oldskool|
      result[:oldskool] = oldskool
    end
  end
  
  command :test do |message, args|
    an_instance_method(message, args)
  end
  
  def an_instance_method(message, args)
    if message == 'Howdy'
      res = "Hey there"
      res << " #{args[:test_option]}" if args[:test_option]
      res
    end
  end
end

describe "LimeChat::Plugin" do
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
  
  it "should forward the command to the plugin with extra arguments" do
    plugin.process_command(:test, 'Howdy --test_option alloy').should == 'Hey there alloy'
  end
  
  private
  
  def plugin
    LimeChat::Plugin
  end
end

describe "LimeChat::Plugin::Base instance" do
  it "should have defined an instance method for a command" do
    instance.test_command('Howdy').should == 'Hey there'
  end
  
  xit "should return the options for a command as a hash" do
    instance.parse_options(:test, %{ --test_option "foo bar" }).should == { :test_option => 'foo bar' }
    
    # instance.parse_test_options(%{ -v "foo bar" }).should == { :value => 'foo bar' }
    # instance.parse_test_options(%{ --value "foo bar" }).should == { :value => 'foo bar' }
    # 
    # instance.parse_test_options(%{ --test_switch }).should == { :test_switch => true }
    # instance.parse_test_options(%{ -s }).should == { :test_switch => true }
  end
  
  private
  
  def instance
    LimeChat::Plugin.plugins.first
  end
end