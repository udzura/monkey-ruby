# rbs_inline: enabled
module MRuby
  class Op
    attr_accessor :code #: Symbol
    attr_accessor :operand #: Array[Integer]
    attr_accessor :pos #: Integer -- keeps original insn top
    attr_accessor :len #: Integer -- keeps original whole insn length

    # @rbs code: Symbol
    # @rbs operand: Array[Integer]
    # @rbs pos: Integer
    # @rbs len: Integer
    def initialize(code, operand, pos=0, len=0)
      @code = code
      @operand = operand
      @pos = pos
      @len = len
    end
  end
end