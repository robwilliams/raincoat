module NumberToWordHelper

  def number_to_word(int)
    case int.to_i
    when 1
      'one'
    when 2
      'two'
    when 3
      'three'
    when 4
      'four'
    when 5
      'five'
    else
      int.to_s
    end
  end
end
