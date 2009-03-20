module LimeChat
  class Plugin
    class << self
      def plugins
        @plugins ||= []
      end
      alias_method :all, :plugins
      
      def define(&block)
        Class.new(self, &block)
      end
      
      def inherited(klass)
        plugins << klass.new
      end
      
      def process_command(command, message)
        method = "#{command}_command"
        if plugin = plugins.find { |p| p.respond_to?(method) }
          plugin.send(method, message)
        end
      end
      
      # subclass methods
      
      def command(name, &block)
        define_method("#{name}_command", &block)
      end
    end
  end
end