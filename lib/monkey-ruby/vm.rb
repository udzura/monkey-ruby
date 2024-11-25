# rbs_inline: enabled

require "monkey-ruby/value"
require "monkey-ruby/op"
require "monkey-ruby/op_table"

module MRuby
  class VM
    include OpTable

    attr_accessor :irep #: Array[IREP]
    attr_accessor :vm_id #: Integer
    attr_accessor :code #: Array[Op]?
    attr_accessor :pc_irep #: IREP
    attr_accessor :pc #: Integer
    attr_accessor :regs #: Array[RObject]
    attr_accessor :current_regs #: Array[RObject]
    attr_accessor :current_callinfo #: CALLINFO?
    attr_accessor :target_class #: RClass
    attr_accessor :error_code #: (Integer|Symbol)?
    attr_accessor :to_interrupt #: bool -- originally flag_preemption

    # @rbs irep: IREP
    # @rbs return: VM
    def self.new_from_irep(irep)
      vm = new
      vm.irep = [irep]
      vm.vm_id = $$
      vm.pc_irep = irep
      vm.pc = 0
      vm.regs = Array.new(255, RObject::NIL)
      vm.current_regs = vm.regs
      vm.current_callinfo = nil
      vm.target_class = RClass::OBJECT
      vm.error_code = 0
      vm.to_interrupt = false
      vm
    end

    # TODO: exception?
    # @rbs return: void
    def run
      loop {
        op = pc_irep.code[pc]
        self.pc += 1
        code = op.code
        case code
        when :END
          self.to_interrupt = true
        when :NOP
          op_nop(self, code, regs)
        else
          raise NotImplementedError, "unsupported op #{code}"
        end

        if to_interrupt?
          break
        end
      }

      self.to_interrupt = false
    end

    alias to_interrupt? to_interrupt
  end

  class IREP
    attr_accessor :nlocals #: Integer
    attr_accessor :nregs #: Integer
    attr_accessor :rlen #: Integer
    attr_accessor :iren #: Integer
    attr_accessor :plen #: Integer
    attr_accessor :code #: Array[Op]
    attr_accessor :syms #: Array[RSym]
    attr_accessor :pools #: Array[RObject]
    attr_accessor :reps #: Array[IREP]
  end

  class CALLINFO
    attr_accessor :prev #: CALLINFO
    attr_accessor :mid #: RSym
    attr_accessor :pc_irep #: IREP
    attr_accessor :pc #: Integer
    attr_accessor :current_regs #: Array[RObject]
    attr_accessor :target_class #: RClass
    attr_accessor :n_args #: Integer
  end
end