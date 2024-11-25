# rbs_inline: enabled
module MRuby
  class RSym
    attr_accessor :sym #: Symbol

    # @rbs sym: Symbol
    def initialize(sym)
      self.sym = sym
    end
  end

  class RObject
    attr_accessor :tt #: Symbol
    attr_accessor :v #: Integer|RSym|Float|RClass|RInstance|RProc|Array[RObject]|Hash[String, RObject]|String|Range[Integer] -- ...?
    # TODO: RObjectがRObjectへのハンドルを持ってるのは？
   
    # @rbs NIL: RObject
    NIL = self.new.tap {|v| v.tt = :nil }
  end

  class RClass
    attr_accessor :sym_id #: RSym
    attr_accessor :super #: RClass?
    attr_accessor :procs #: Array[RProc]

    OBJECT = self.new.tap do |klass|
      klass.sym_id = RSym.new(:Object)
      klass.procs = []
    end
  end

  class RInstance
    attr_accessor :cls #: RClass
    attr_accessor :ivar #: Hash[RSym, RObject]
    attr_accessor :data #: Object|nil -- CRuby-level data, everything
    attr_accessor :ref_count #: Integer
  end

  class RProc
    attr_accessor :is_rb_func #: Integer // 0:IREP, 1:Ruby Proc
    attr_accessor :sym_id #: RSym
    attr_accessor :next #: RProc
    attr_accessor :irep #: IREP
    attr_accessor :func #: Proc 
  end
end