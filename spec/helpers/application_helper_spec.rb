require 'rspec'         # for non-Rails
#require 'rails_helper'  # for Rails

describe "ApplicationHelper" do
  example 'time_range_to_string' do
    expect(time_range_string(0)).to eq '指定なし'
    expect(time_range_string(1)).to eq '午前中（12時まで）'
    expect(time_range_string(2)).to eq '14時～16時'
    expect(time_range_string(3)).to eq '16時～18時'
    expect(time_range_string(4)).to eq '18時～20時'
    expect(time_range_string(5)).to eq '19時～21時'
  end
end