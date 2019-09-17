module Abstrakt
  module Exceptions
    class InstanceMethodNotImplementedError < NotImplementedError
      def initialize(level:, object:, method:)
        super("not implemented #{level} instance method '#{method}' for class "\
              "#{object.to_s}")
      end
    end

    class InstantiationError < RuntimeError
      def initialize(object)
        super("class '#{object}' can not be instantiated")
      end
    end
  end
end
