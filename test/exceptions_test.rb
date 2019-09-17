require 'test_helper'

class AbstraktExceptionsTest < Minitest::Test
  describe Abstrakt::Exceptions::InstanceMethodNotImplementedError do
    it 'throws NotImplementedError type exception' do
      proc do
        raise Abstrakt::Exceptions::InstanceMethodNotImplementedError.new(
          {level: :private, method: :some, object: Class})
      end.must_raise NotImplementedError
    end

    it 'requires security level, method name and object name to raise' do
      proc do
        raise Abstrakt::Exceptions::InstanceMethodNotImplementedError.new
      end.must_raise ArgumentError
    end
  end

  describe Abstrakt::Exceptions::InstantiationError do
    it 'throws RuntimeError type exception' do
      proc do
        raise Abstrakt::Exceptions::InstantiationError.new Class
      end.must_raise RuntimeError
    end

    it 'requires object to raise' do
      proc do
        raise Abstrakt::Exceptions::InstantiationError.new
      end.must_raise ArgumentError
    end
  end
end
