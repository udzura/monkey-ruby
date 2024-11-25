# frozen_string_literal: true

require "test_helper"

class MRubyVMTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::MRuby.const_defined?(:VERSION)
    end
  end

  test "It doesn't smoke" do
    irep = MRuby::IREP.new
    irep.code = [
      MRuby::Op.new(:NOP, []),
      MRuby::Op.new(:END, []),
    ]
    vm = MRuby::VM.new_from_irep(irep)
    assert_nothing_raised { vm.run }
  end

  test "It smokes" do
    irep = MRuby::IREP.new
    irep.code = [
      MRuby::Op.new(:UNREACHABLE, []),
    ]
    vm = MRuby::VM.new_from_irep(irep)
    assert_raise(NotImplementedError) { vm.run }
  end
end
