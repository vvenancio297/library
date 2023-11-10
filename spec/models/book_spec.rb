# frozen_string_literal: true

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

  describe '#available?' do
    context "when it's not returned" do
      let(:lent) { Reservation.statuses[:lent] }
      let(:user) { create(:user, :admin) }
      let(:book) { create(:book) }
      
      before do
        create(:reservation, book_id: book.id, user_id: user.id, status: lent)
      end

      it "returns false" do
        expect(book.available?).to eq(false)
      end
    end

    context "when it's returned" do
      let(:book) { build(:book) }

      it "returns false" do
        expect(book.available?).to eq(true)
      end
    end
  end

  describe '.search' do
    let!(:book) { create(:book) }

    context 'when query is present' do
      let(:other_book) { create(:book, author: 'Guimaraes Rosa') }
      let(:query) { 'Guimaraes Rosa' }

      before do
        create(:book, author: 'Oscar Wild', title: 'Test', description: 'Test')
      end
      
      it 'queries book by its author, title, genre or description' do
        books = Book.search(query)
        expect(books).to eq([other_book])
      end
    end

    context 'when query is not present' do
      it 'returs self' do
        books = Book.search(nil)
        expect(books).to eq([book])
      end
    end
  end
end
