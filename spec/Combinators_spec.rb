require 'rspec'
require_relative '../src/Matcher'
require_relative '../src/Symbol'
require_relative '../src/Combinators'

describe ' Matcher ' do
  self.define_singleton_method(:include_matcher){include Matcher}
  self.include_matcher

  class Guerrero

  end

  module Defensor

    def descansar
      self.energia += 10
    end

  end
  module Atacante

    def atacar(un_defensor)
      if self.potencial_ofensivo > un_defensor.potencial_defensivo
        danio = self.potencial_ofensivo - un_defensor.potencial_defensivo
        un_defensor.sufri_danio(danio)
      end
      self.descansado = false
    end

    def potencial_ofensivo
      self.descansado ? @potencial_ofensivo * 2 : @potencial_ofensivo
    end

    def descansar
      self.descansado = true
    end

  end
  class Guerrero
    include Atacante
    include Defensor
  end
  class Muralla
    include Defensor
    def fly
      '(headache)'
    end
  end
  una_muralla=Muralla.new
  un_guerrero=Guerrero.new



  it 'and: se cumple si se cumplen todos los matchers de la composición.' do

    #puts "defensor #{type(una_muralla)}"
    expect(type(Atacante).and(type(Defensor)).call(una_muralla)).to eq(false)
    expect(type(Defensor).and(type(Atacante)).call(un_guerrero)).to eq(true)
    expect(duck(:+).and(type(Fixnum), val(5)).call(5)).to eq(true)

  end



  it 'or: se cumple si se cumple al menos uno de los matchers de la composición.' do

    expect(type(Defensor).or(type(Atacante)).call(una_muralla)).to eq(true)
    expect(type(Defensor).or(type(Atacante)).call('un delfín')).to eq(false)

  end


  it 'not: genera el matcher opuesto.' do
    un_misil = Object.new
    expect(type(Defensor).not.call(una_muralla)).to eq(false)
    expect(type(Defensor).not.call(un_misil)).to eq(true)

  end



end

