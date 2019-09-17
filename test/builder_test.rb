require 'test_helper'

class AbstraktBuilderTest < Minitest::Test
  describe Abstrakt::Builder do
    class SubjectAbstractClass
      extend Abstrakt::Builder
      public_abstract :some_public_method
      protected_abstract :some_protected_method
      private_abstract :some_private_method
    end

    describe 'extendable abstract class' do
      it 'raises error on instantiation' do
        proc do
          SubjectAbstractClass.new
        end.must_raise Abstrakt::Exceptions::InstantiationError
      end
    end

    describe 'inherited implementation class' do
      it 'raises error when class not implements all abstract methods' do
        proc do
          class SomeImplementationClass1 < SubjectAbstractClass; end
        end.must_raise Abstrakt::Exceptions::InstanceMethodNotImplementedError
      end

      it 'raises error when class not implements public abstract methods' do
        proc do
          class SomeImplementationClass2 < SubjectAbstractClass
            private def some_private_method; end
            protected def some_protected_method; end
          end
        end.must_raise Abstrakt::Exceptions::InstanceMethodNotImplementedError
      end

      it 'raises error when class not implements protected abstract methods' do
        proc do
          class SomeImplementationClass3 < SubjectAbstractClass
            public def some_public_method; end
            private def some_private_method; end
          end
        end.must_raise Abstrakt::Exceptions::InstanceMethodNotImplementedError
      end

      it 'raises error when class not implements private abstract methods' do
        proc do
          class SomeImplementationClass4 < SubjectAbstractClass
            public def some_public_method; end
            protected def some_protected_method; end
          end
        end.must_raise Abstrakt::Exceptions::InstanceMethodNotImplementedError
      end

      describe 'when all abstract methods are implemented' do
        class SomeCorrectImplementationClass < SubjectAbstractClass
          public def some_public_method; end
          protected def some_protected_method; end
          private def some_private_method; end
        end

        it 'declares successfully' do
          -> { SomeCorrectImplementationClass }.must_be_silent
        end

        it 'can instantiate class' do
          SomeCorrectImplementationClass.new.must_be_kind_of(
            SomeCorrectImplementationClass)
        end
      end
    end
  end
end
