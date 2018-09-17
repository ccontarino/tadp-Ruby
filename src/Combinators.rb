require_relative './Matcher'
class Combinators < Proc

  attr_accessor :lastResult
  def initialize()

    @lastResult = []
    super
  end

  def and(*valueMatch)
    Combinators.new do
    |objectFinal| self.call(objectFinal) && valueMatch.all?{ |m| m.call(objectFinal)}
    end
  end

  def or(*valueMatch)
    Combinators.new do
    |objectFinal| self.call(objectFinal) || valueMatch.any?{ |m| m.call(objectFinal)}
    end


  end

  def not(*valueMatch)
    Combinators.new do
    |objectFinal| not self.call(objectFinal) || valueMatch.any?{ |m| m.call(objectFinal)}
    end


  end

end