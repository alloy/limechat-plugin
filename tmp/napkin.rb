module LimeChat
  class Plugin
    class << self
      def plugins
        @plugins ||= []
      end
      
      def try(method, *args)
        plugins.each { |p| (result = p.send(method, *args)) && (return result) }
        nil
      end
      
      def send_command(cmd, msg)
        try(:send_command, cmd, msg)
      end
      
      def inherited(klass)
        plugins << klass.new
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

class MyPlugin1 < LimeChat::Plugin
  def send_command(cmd, msg)
    'foo' if cmd == :foo
  end
end

class MyPlugin2 < LimeChat::Plugin
  def send_command(cmd, msg)
    'bar' if cmd == :bar
  end
end

u = Unit.new
p u.send_command(:privmsg, 'normal') # => "privmsg: normal"
p u.send_command(:nonexistant, 'nonexistant') # => nil
p u.send_command(:foo, '') # => "plugin: foo"
p u.send_command(:bar, '') # => "plugin: bar"