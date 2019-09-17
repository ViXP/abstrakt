module Abstrakt
  module Builder
    def self.extended(klass)
      super(klass)
      class << klass
        alias_method :_new, :new
        alias_method :new, :abstract_class_instantiation
      end
    end

    def abstract_class_instantiation
      raise Abstrakt::Exceptions::InstantiationError.new(self)
    end

    private

      Abstrakt::SECURITY_LEVELS.each do |level|
        define_method("#{level}_abstract") do |method_name|
          abstract(method_name, level)
        end
      end

      def inherited(klass)
        class << klass
          alias_method :new, :_new
        end
        super(klass)
        TracePoint.new(:end) do |trace|
          if trace.self == klass
            klass.check_abstract_methods
            trace.disable
          end
        end.enable
      end

      def abstract(method_name, level = :public)
        @abstract_methods ||= {}
        @abstract_methods[level] ||= []
        @abstract_methods[level] << method_name
      end

    protected

      def check_abstract_methods
        abstractions = self.superclass.instance_variable_get(:@abstract_methods)

        return unless abstractions && abstractions.any?

        Abstrakt::SECURITY_LEVELS.each do |level|
          abstractions[level] && abstractions[level].each do |method_name|
            next if self.send("#{level}_instance_methods").include? method_name
            raise Abstrakt::Exceptions::InstanceMethodNotImplementedError.new(
                level: level, object: self, method: method_name)
          end
        end
      end
  end
end
