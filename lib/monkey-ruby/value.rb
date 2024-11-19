# rbs_inline: enabled
module MRuby
  class RObject
    attr_accessor :tt #: Symbol
    attr_accessor :v #: Integer|RSym|Float|RClass|RInstance|RProc|Array[RObject]|Hash[String, RObject]|String|Range[Integer] -- ...?
    # TODO: RObjectがRObjectへのハンドルを持ってるのは？
  end

  class RClass
    attr_accessor :sym_id #: RSym
    attr_accessor :super #: RClass|nil
    attr_accessor :procs #: Array[RProc]
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

  class RSym
    attr_accessor :sym #: Symbol
  end
end