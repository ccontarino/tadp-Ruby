require 'rspec'
require_relative '../src/Matcher'
require_relative '../src/Symbol'

describe ' Matcher ' do
  self.define_singleton_method(:include_matcher){include Matcher}
  self.include_matcher
  it 'de variable: se cumple siempre. Vendría a ser el matcher identidad. Su verdadera utilidad es bindear las variables (más sobre binding en la próxima sección).' do

    #puts "#{self.methods(regular=false)}"
    expect(:a_variable_name.call('anything')).to eq(true)

  end

  it 'de valor: se cumple si el valor del objeto es idéntico al indicado.' do
    self.define_singleton_method(:include_matcher){include Matcher}
    self.include_matcher
    expect(val(5).call(5)).to eq(true)
    expect(val(5).call('5')).to eq(false)
    expect(val(5).call(4)).to eq(false)
  end

  it 'de tipo: se cumple si el objeto es del tipo indicado.' do
    self.define_singleton_method(:include_matcher){include Matcher}
    self.include_matcher
    expect(type(Integer).call(5)).to eq(true)
    expect(type(Symbol).call("Trust me, I'm a Symbol..")).to eq(false)
    expect(type(Symbol).call(:a_real_symbol)).to eq(true)
  end

  it 'de listas: se cumple si el objeto es una lista, cuyos primeros N elementos coinciden con los indicados; puede además requerir que el tamaño de la lista sea N.' do
    self.define_singleton_method(:include_matcher){include Matcher}
    self.include_matcher
    an_array = [1, 2, 3, 4]
    expect(list([1, 2, 3, 4], true).call(an_array)).to eq(true)
    expect(list([1, 2, 3, 4], false).call(an_array)).to eq(true)


    expect(list([1, 2, 3], true).call(an_array)).to eq(false)
    expect(list([1, 2, 3], false).call(an_array)).to eq(true)


    expect(list([2, 1, 3, 4], true).call(an_array)).to eq(false)
    expect(list([2, 1, 3, 4], false).call(an_array)).to eq(false)

    expect(list([2, 1, 3, 4], true).call(an_array)).to eq(false)
    expect(list([2, 1, 3, 4], false).call(an_array)).to eq(false)

    expect(list([1, 2, 3]).call(an_array)).to eq(false)

    expect(list([:a, :b, :c, :d]).call(an_array)).to eq(true)

  end


  it 'duck typing: se cumple si el objeto entiende una serie de mensajes determinados.' do
    self.define_singleton_method(:include_matcher){include Matcher}
    self.include_matcher

    class Psyduck
      def cuack
        'psy..duck?'
      end
      def fly
        '(headache)'
      end
    end

    class Dragon
      def fly
        'do some flying'
      end
    end
    a_dragon = Dragon.new
    psyduck = Psyduck.new

    expect(duck(:cuack, :fly).call(psyduck)).to eq(true)
    expect(duck(:cuack, :fly).call(a_dragon)).to eq(false)
    expect(duck(:fly).call(a_dragon)).to eq(true)
    expect(duck(:to_s).call(Object.new)).to eq(true)
  end


end

