require File.expand_path('../test_helper', __FILE__)
require File.expand_path('../../lib/ignore', __FILE__)

describe 'Ignore' do
  it "should have registered the `ignore' command" do
    assert LimeChat::Plugin.all.any? { |p| p.respond_to?(:ignore_command) }
  end
end
