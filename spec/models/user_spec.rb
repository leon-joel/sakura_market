require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#password=" do
    example "文字列を与えると、password_digest は長さ60の文字列になる" do
      user = User.new
      user.password = 'abc'
      expect(user.password_digest).to be_kind_of(String)
      expect(user.password_digest.size).to eq 60
    end

    example 'nilを与えると、password_digest もnilになる' do
      user = User.new(password_digest: 'x')
      user.password = nil
      expect(user.password_digest).to be_nil
    end

    example 'string以外を与えると, password_digestは変化しない' do
      user = User.new(password_digest: 'x')
      user.password = 1
      expect(user.password_digest).to eq 'x'
    end
  end
end
