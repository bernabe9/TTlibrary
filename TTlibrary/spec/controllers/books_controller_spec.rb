require "spec_helper"
require "rails_helper"

describe BooksController do
let(:book) { create(:book) }
let(:book2) { create(:book) }

  describe "GET #home" do
    it "populates an array of all books" do
      get :home
      expect(assigns(:books)).to eq([book, book2])
    end

    it "renders the :home view" do
      get :home
      expect(response).to render_template(:home)
    end  
  end
  
  describe "GET #index" do
    it "populates an array of the author's books" do
      get :index, author_id: book.author.id
      expect(assigns(:books)).to eq([book])
      expect(assigns(:books)).not_to include(book2)
    end

    it "renders the :index view" do
      get :index, author_id: book.author.id
      expect(response).to render_template(:index)
    end
  end
  
  describe "GET #show" do

    it "assigns the requested book to @book" do
      get :show, id: book, author_id: book.author.id
      expect(assigns(:book)).to eq(book)
    end

    it "renders the :show template" do
      get :show, id: book, author_id: book.author.id
      expect(response).to render_template(:show)
    end
  end
  
  describe "GET #new" do
    it "assigns a new book to @book" do
      get :new, author_id: book.author.id
      expect(assigns(:book)).to be_a_new(Book)
    end
    it "renders the :new template" do
      get :new, author_id: book.author.id
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:author){ create(:author) }

    context "with valid attributes" do
      it "saves the new book in the database" do
        expect{ post :create, book: attributes_for(:book), author_id: book.author }.to change(Book,:count).by(1)
      end
      it "redirects to the show book" do
        get :show, id: book, author_id: book.author.id
        expect(response).to render_template(:show)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new book in the database" do
         expect{ post :create, book: attributes_for(:book, title: nil), author_id: author.id }.to_not change(Book,:count)
         expect{ post :create, book: attributes_for(:book, year: nil), author_id: author.id }.to_not change(Book,:count)
         expect{ post :create, book: attributes_for(:book, ISBN: nil), author_id: author.id }.to_not change(Book,:count)
      end
      it "re-renders the :new template" do
        get :new, author_id: author
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:book) { create(:book) }

    it "deletes the book" do
      expect{ delete :destroy, id: book, author_id: book.author.id }.to change(Book,:count).by(-1)
    end
      
    it "redirects to books#index" do
      delete :destroy, id: book, author_id: book.author.id
      expect(response).to redirect_to(author_books_url)
    end
  end
end
