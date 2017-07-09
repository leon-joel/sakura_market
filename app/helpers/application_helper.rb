module ApplicationHelper

  def number_to_jpy(numeric)
    # number_to_currency(numeric, unit: '\\ ', precision: 0)
    # number_to_currency(numeric)
    number_to_currency(numeric, unit: "￥ ", separator: ".", delimiter: ",", format: "%u %n")
  end

end
