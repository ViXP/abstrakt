require "test_helper"

class AbstraktTest < Minitest::Test
  describe Abstrakt do
    describe 'constants' do
      it 'declares SECURITY_LEVELS array constant' do
        Abstrakt::SECURITY_LEVELS.must_be_kind_of Array
        Abstrakt::SECURITY_LEVELS.wont_be_empty
      end
    end
  end
end
