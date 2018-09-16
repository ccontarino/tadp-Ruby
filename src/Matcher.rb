module Matcher
  def val(param)
  proc { |param2| param.equal?param2 }
  end

  def type(type_param)
    proc { |param| param.is_a?type_param }
  end

  def list(list, param2 = true) proc do
  |param|
    if (list.first.is_a?Symbol)
      true
    else
      if param2
        list.slice(0,param.length)==param
      else
        if ((list & param).length < param.length)
          (list & param) == list
        else
          (list & param) == param
        end
      end
    end
  end
  end

  def duck(*listSelector) proc do | object |
    listSelector.all?{ |selector| object.respond_to?(selector.to_sym, include_all=false) }
  end
  end

end
