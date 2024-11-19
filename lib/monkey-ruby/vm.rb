# rbs_inline: enabled

require "monkey-ruby/value"
require "monkey-ruby/op"

module MRuby
  class VM
    attr_accessor :irep #: Array[IREP]

    attr_accessor :vm_id #: Integer

    attr_accessor :code #: Array[Op]

    attr_accessor :pc_irep #: IREP

    attr_accessor :pc #: Integer

    attr_accessor :regs #: Array[RObject]

    attr_accessor :current_regs #: Array[RObject]

    attr_accessor :current_callinfo #: CALLINFO

    attr_accessor :target_class #: RClass

    attr_accessor :error_code #: Integer|Symbol?

    attr_accessor :interrupt #: bool -- originally flag_preemption
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