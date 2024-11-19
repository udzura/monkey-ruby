# rbs_inline: enabled
module MRuby
  class Op
    attr_accessor :code #: Integer|Symbol
    attr_accessor :operand #: Array[Integer]
    attr_accessor :pos #: Integer -- keeps original insn top
    attr_accessor :len #: Integer -- keeps original whole insn length
  end
end