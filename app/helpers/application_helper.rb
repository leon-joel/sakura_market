module ApplicationHelper

  def number_to_jpy(numeric)
    # number_to_currency(numeric, unit: '\\ ', precision: 0)
    # number_to_currency(numeric)
    number_to_currency(numeric, unit: "￥ ", separator: ".", delimiter: ",", format: "%u %n")
  end

  def time_range_to_string(range_value)
    case range_value
      when 0 then '指定なし'
      when 1 then '午前中（12時まで）'
      when 2 then '14時～16時'
      when 3 then '16時～18時'
      when 4 then '18時～20時'
      when 5 then '19時～21時'
      else '指定なし'
    end
  end
end
