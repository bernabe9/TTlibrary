require "spec_helper"
require "rails_helper"

describe CommentsController do
  let(:comment) { create(:comment) }
  
  describe "GET #index" do
    it "populates an array of book's comments" do
      get :index, book_id: comment.book, author_id: comment.book.author
      expect(assigns(:comments)).to eq([comment])
    end

    it "renders the :index view" do
      get :index, book_id: comment.book, author_id: comment.book.author
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    context "user signed in" do
      before { sign_in comment.user }

      context "with valid attributes" do
        it "saves the new comment in the database" do
          expect{ post :create, comment: attributes_for(:comment), book_id: comment.book, author_id: comment.book.author }.to change(Comment,:count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new comment in the database" do
           expect{ post :create, comment: attributes_for(:comment, text: nil), book_id: comment.book, author_id: comment.book.author }.to_not change(Comment,:count)
        end
      end
    end

    context "not signed in" do
      let!(:comment) { create(:comment) }
      it "does not save the new comment in the database" do
        expect{ post :create, comment: attributes_for(:comment), book_id: comment.book, author_id: comment.book.author }.to_not change(Comment,:count)
      end
    end
  end

  describe 'PUT update' do
    it "located the requested @comment" do
      put :update, id: comment, book_id: comment.book, author_id: comment.book.author, comment: attributes_for(:comment)
      expect(assigns(:comment)).to eq(comment)
    end

    context "user signed in and comment owner" do
      before { sign_in comment.user }
      
      context "valid attributes" do    
        it "changes @comment's attributes" do
          put :update, id: comment, book_id: comment.book, author_id: comment.book.author, comment: attributes_for(:comment, text: "comment edited")
          comment.reload
          expect(comment.text).to eq("comment edited")
        end
      end

      context "invalid attributes" do
        it "does not change @comment's attributes" do
          put :update, id: comment, book_id: comment.book, author_id: comment.book.author, comment: attributes_for(:comment, text: nil)
          comment.reload
          expect(comment.text).to_not eq(nil)
        end
      end
    end

    context "user signed in and not comment owner" do
      before(:each) do
        @user = create(:user, email: "pedro@gmail.com")
        sign_in @user
      end
        
      it "does not change @comment's attributes" do
        put :update, id: comment, book_id: comment.book, author_id: comment.book.author, comment: attributes_for(:comment, text: "comment edited")
        comment.reload
        expect(comment.text).to_not eq("comment edited")
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:comment) { create(:comment) } 
    
    context "user signed in and comment owner" do
      it "deletes the comment" do
        sign_in comment.user
        expect{ delete :destroy, id: comment, book_id: comment.book, author_id: comment.book.author }.to change(Comment,:count).by(-1)
      end
    end

    context "user signed in and not comment owner" do
      it "does not delete the comment in the database" do
        user = create(:user, email: "pedro@gmail.com")
        sign_in user
        expect{ delete :destroy, id: comment, book_id: comment.book, author_id: comment.book.author }.to_not change(Comment,:count)
      end
    end   
  
  end

end
