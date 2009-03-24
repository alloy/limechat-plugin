module LimeChat
  module Plugin
    class << self
      def plugins
        @plugins ||= []
      end
      alias_method :all, :plugins
      
      def define(&block)
        plugins << Class.new(Base, &block).new
      end
      
      def process_command(command, message)
        method = "#{command}_command"
        if plugin = plugins.find { |p| p.respond_to?(method) }
          plugin.send(method, message, args)
        end
      end
    end
    
    class Base
      class << self
        def command(name, &block)
          define_method("#{name}_command", &block)
        end
        
        def options_for(name, &block)
          define_method("parse_#{name}_options") do |args|
            
          end
        end
      end
      
      def parse_options(name, string)
        if options_block = self.class.options[name]
          options, result = OptionParser.new, {}
          options_block.call(options, result)
          options.parse(string)
        end
      end
    end
  end
end