require 'rails_helper'

RSpec.describe "/books", type: :request do
  let!(:admin) { create(:user, :admin) }

  before(:each) do
    Warden.test_mode!
    login_as(admin, scope: :user)
  end

  after(:each) do
    Warden.test_reset!
  end

  let(:valid_attributes) {
    {
      author: 'Some guy',
      genre: 'Some genre',
      title: 'Some title',
      description: 'Some description'
    }
  }

  let(:invalid_attributes) {
    {
      author: 'Some guy',
      title: 'Some title',
      description: 'Some description'
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Book.create! valid_attributes
      get books_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_book_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      book = Book.create! valid_attributes
      get edit_book_url(book)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Book" do
        expect {
          post books_url, params: { book: valid_attributes }
        }.to change(Book, :count).by(1)
      end

      it "redirects to the created book" do
        post books_url, params: { book: valid_attributes }
        expect(response).to redirect_to(books_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Book" do
        expect {
          post books_url, params: { book: invalid_attributes }
        }.to change(Book, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post books_url, params: { book: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          author: 'Guimaraes Rosa'
        }
      }

      it "updates the requested book" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: new_attributes }
        book.reload
        expect(book.author).to eq(new_attributes[:author])
      end

      it "redirects to the book" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: new_attributes }
        book.reload
        expect(response).to redirect_to(books_url)
      end
    end

    context "with invalid parameters" do
      let(:invalid_author) do
        {
          author: ''
        }
      end
      
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: invalid_author }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end
end
