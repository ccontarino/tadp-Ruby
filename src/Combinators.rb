require_relative './Matcher'

module Combinators
attr_accessor :lastResult
  def initialize(value)
  @lastResult = []
  @lastResult.push(value);
  end

  def and(value)
    @lastResult.push(value);
  end



end