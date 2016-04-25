require "spec_helper"
require "rails_helper"

describe BooksController do
  describe "GET #home" do
    it "populates an array of all books" do
      author1 = create(:author)
      author2 = create(:author)
      book1 = create(:book, author: author1)
      book2 = create(:book, author: author2)
      get :home
      expect(assigns(:books)).to eq([book1, book2])
    end    
  end
  
  it "renders the :home view" do
      get :home
      response.should render_template :home
  end

  describe "GET #index" do
    it "populates an array of the author's books" do
      author1 = create(:author)
      author2 = create(:author)
      book1 = create(:book, author: author1)
      book2 = create(:book, author: author2)
      get :index, author_id: author1.id
      expect(assigns(:books)).to eq([book1])
      expect(assigns(:books)).not_to include(book2)
    end

    it "renders the :index view" do
      author = create(:author)
      get :index, author_id: author.id
      response.should render_template :index
    end
  end
  
  describe "GET #show" do

    it "assigns the requested book to @book" do
      author = create(:author)
      book = create(:book)
      get :show, id: book, author_id: author
      expect(assigns(:book)).to eq(book)
    end

    it "renders the :show template" do
      get :show, id: create(:book), author_id: create(:author)
      response.should render_template :show
    end

  end
  
  describe "GET #new" do
    it "assigns a new book to @book" do
      get :new, author_id: create(:author)
      expect(assigns(:book)).to be_a_new(Book)
    end
    it "renders the :new template" do
      get :new, author_id: create(:author)
      response.should render_template :new
    end
  end

  describe "POST #create" do
    before { @author = create(:author) }

    context "with valid attributes" do
      it "saves the new book in the database" do
        expect{ post :create, book: attributes_for(:book), author_id: @author }.to change(Book,:count).by(1)
      end
      it "redirects to the show book" do
        get :show, id: create(:book), author_id: @author
        response.should render_template :show
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new book in the database" do
         expect{ post :create, book: attributes_for(:book, title: nil), author_id: @author }.to_not change(Book,:count)
         expect{ post :create, book: attributes_for(:book, year: nil), author_id: @author }.to_not change(Book,:count)
         expect{ post :create, book: attributes_for(:book, ISBN: nil), author_id: @author }.to_not change(Book,:count)
      end
      it "re-renders the :new template" do
        get :new, author_id: @author
        response.should render_template :new
      end
    end
  end

  describe 'DELETE destroy' do
  before { @author = create(:author) }
  before { @book = create(:book, author: @author) }
    
    it "deletes the book" do
      expect{
        delete :destroy, id: @book, author_id: @author        
      }.to change(Book,:count).by(-1)
    end
      
    it "redirects to books#index" do
      delete :destroy, id: @book, author_id: @author
      response.should redirect_to author_books_url
    end

  end

end
