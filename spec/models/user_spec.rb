require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires email' do
      user = User.new(password: '123456', role: 'admin')
      errors = ["Email can't be blank"]
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to eq(errors)
    end

    it 'requires password' do
      user = User.new(email: 'test@test.com', role: 'admin')
      errors = ["Password can't be blank"]
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to eq(errors)
    end

    it 'requires role' do
      user = User.new(email: 'test@test.com', password: '123456', role: nil)
      errors = ["Role can't be blank"]
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to eq(errors)
    end

    it 'requires a 6 chars password' do
      user = User.new(email: 'test@test.com', password: '1256', role: 'admin')
      errors = ["Password is too short (minimum is 6 characters)"]
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to eq(errors)
    end
  end
end
