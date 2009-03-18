module LimeChat
  class Plugin
    class << self
      def plugins
        @plugins ||= []
      end
      
      def define(&block)
        plugins << Class.new(Plugin, &block).new
      end
      
      def try(method, *args)
        plugins.each { |p| (result = p.send(method, *args)) && (return result) }
        nil
      end
      
      def send_command(cmd, msg)
        try(:send_command, cmd, msg)
      end
    end
    
    def send_command(*args, &block)
    end
  end
end

class Unit
  def send_command(cmd, msg)
    if extended_message = LimeChat::Plugin.send_command(cmd, msg)
      "plugin: #{extended_message}"
    else
      case cmd
      when :privmsg
        "privmsg: #{msg}"
      end
    end
  end
end

LimeChat::Plugin.define do
  def send_command(cmd, msg)
    'foo' if cmd == :foo
  end
end

LimeChat::Plugin.define do
  def send_command(cmd, msg)
    'bar' if cmd == :bar
  end
end

u = Unit.new
p u.send_command(:privmsg, 'normal') # => "privmsg: normal"
p u.send_command(:nonexistant, 'nonexistant') # => nil
p u.send_command(:foo, '') # => "plugin: foo"
p u.send_command(:bar, '') # => "plugin: bar"