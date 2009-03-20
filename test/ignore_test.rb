require File.expand_path('../test_helper', __FILE__)

#require "ignore"

describe 'Ignore' do
  it "should have registered the `ignore' command" do
    LimeChat::Plugin.command(:ignore, 'alloy')
  end
end
