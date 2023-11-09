require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it 'requires title' do
      book_attrs = {
        author: 'Julio Verne',
        genre: 'Drama',
        description: 'Very nice book'
      }
      user = Book.new(book_attrs)
      errors = ["Title can't be blank"]
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to eq(errors)
    end

    it 'requires author' do
      book_attrs = {
        title: 'Twilight',
        genre: 'Drama',
        description: 'Very nice book'
      }
      user = Book.new(book_attrs)
      errors = ["Author can't be blank"]
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to eq(errors)
    end

    it 'requires genre' do
      book_attrs = {
        title: 'Twilight',
        author: 'Machado de Assis',
        description: 'Very nice book'
      }
      user = Book.new(book_attrs)
      errors = ["Genre can't be blank"]
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to eq(errors)
    end

    it 'requires genre' do
      book_attrs = {
        title: 'Twilight',
        author: 'Machado de Assis',
        genre: 'Drama',
      }
      user = Book.new(book_attrs)
      errors = ["Description can't be blank"]
      expect(user.valid?).to be_falsey
      expect(user.errors.full_messages).to eq(errors)
    end
  end
end
