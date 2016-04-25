require "spec_helper"
require "rails_helper"

describe RequestsController do
  describe "GET #index" do
    before(:each) do
      @author = create(:author)
      @book = create(:book, author_id: @author.id)
      @user = create(:user)
      sign_in @user
    end 

    it "populates an array of user's requests" do
      request = create(:request, user_id: @user.id, book_id: @book.id)
      get :index, user_id: @user
      expect(assigns(:requests)).to eq([request])
    end

    it "renders the :index view" do
      get :index, user_id: @user
      response.should render_template :index
    end
  end

  describe "POST #create" do
    before(:each) do
        @user = create(:user)
        @book = create(:book, author_id: create(:author).id)
    end

    context "user signed in" do
      before { sign_in @user}
      it "saves the new request in the database" do
        expect{ post :create, request: attributes_for(:request), user_id: @user, book_id: @book }.to change(Request,:count).by(1)
      end
    end

    context "user not signed in" do
      it "does not save the new request in the database" do
        expect{ post :create, request: attributes_for(:request), user_id: @user, book_id: @book }.to_not change(Request,:count)
      end
    end
  end

  describe 'DELETE destroy' do
    
    context "user signed" do
      it "deletes the request" do
        user = create(:user)
        sign_in user
        book = create(:book, author_id: create(:author).id)
        request = create(:request, book_id: book.id, user_id: user.id)
        expect{ delete :destroy, id: request, book_id: book, user_id: user }.to change(Request,:count).by(-1)
      end
    end

    context "user not signed" do
      it "does not delete the request in the database" do
        user = create(:user)
        book = create(:book, author_id: create(:author).id)
        request = create(:request, book_id: book.id, user_id: user.id)
        expect{ delete :destroy, id: request, book_id: book, user_id: user }.to_not change(Request,:count)
      end
    end    
 
  end

end
