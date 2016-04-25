require "spec_helper"
require "rails_helper"

describe CommentsController do
  describe "GET #index" do
  before { @author = create(:author) }
  before { @book = create(:book, author_id: @author.id) }

    it "populates an array of book's comments" do
      user = create(:user)
      comment = create(:comment, book_id: @book.id, user_id: user.id)
      get :index, book_id: @book, author_id: @book.author
      expect(assigns(:comments)).to eq([comment])
    end

    it "renders the :index view" do
      get :index, book_id: @book, author_id: @author
      response.should render_template :index
    end
  end

  describe "POST #create" do
    context "user signed in" do
      before(:each) do
        @user = create(:user)
        sign_in @user
        @book = create(:book, author_id: create(:author).id)
      end

      context "with valid attributes" do
        it "saves the new comment in the database" do
          expect{ post :create, comment: attributes_for(:comment), book_id: @book, author_id: @book.author }.to change(Comment,:count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not save the new comment in the database" do
           expect{ post :create, comment: attributes_for(:comment, text: nil), book_id: @book, author_id: @book.author }.to_not change(Comment,:count)
        end
      end
    end

    context "not signed in" do
      it "does not save the new comment in the database" do
        @book = create(:book, author_id: create(:author).id)
        expect{ post :create, comment: attributes_for(:comment), book_id: @book, author_id: @book.author }.to_not change(Comment,:count)
      end
    end

  end

  describe 'PUT update' do
    context "user signed in and comment owner" do
      before(:each) do
        @user = create(:user)
        sign_in @user
        @book = create(:book, author_id: create(:author).id)
        @comment = create(:comment, book_id: @book.id, user_id: @user.id)
      end

      context "valid attributes" do
        it "located the requested @comment" do
          put :update, id: @comment, book_id: @book, author_id: @book.author, comment: attributes_for(:comment)
          assigns(:comment).should eq(@comment)
        end
      end
    
      it "changes @comment's attributes" do
        put :update, id: @comment, book_id: @book, author_id: @book.author, comment: attributes_for(:comment, text: "comment edited")
        @comment.reload
        @comment.text.should eq("comment edited")
      end
    
      context "invalid attributes" do
        it "locates the requested @comment" do
          put :update, id: @comment, book_id: @book, author_id: @book.author, comment: attributes_for(:comment)
          assigns(:comment).should eq(@comment)      
        end
        
        it "does not change @comment's attributes" do
          put :update, id: @comment, book_id: @book, author_id: @book.author, comment: attributes_for(:comment, text: nil)
          @comment.reload
          @comment.text.should_not eq(nil)
        end
      end
    end

    context "user signed in and not comment owner" do
      before(:each) do
        @user = create(:user)
        sign_in @user
        @book = create(:book, author_id: create(:author).id)
        @comment = create(:comment, book_id: @book.id, user_id: @user.id + 1)
      end

      it "locates the requested @comment" do
          put :update, id: @comment, book_id: @book, author_id: @book.author, comment: attributes_for(:comment)
          assigns(:comment).should eq(@comment)      
        end
        
      it "does not change @comment's attributes" do
        put :update, id: @comment, book_id: @book, author_id: @book.author, comment: attributes_for(:comment, text: "comment edited")
        @comment.reload
        @comment.text.should_not eq("comment edited")
      end
    end
  end


  describe 'DELETE destroy' do
    before(:each) do
      @user = create(:user)
      sign_in @user
      @book = create(:book, author_id: create(:author).id)    
    end
    
    context "user signed in and comment owner" do
      it "deletes the comment" do
        comment = create(:comment, book_id: @book.id, user_id: @user.id)
        expect{ delete :destroy, id: comment, book_id: @book, author_id: @book.author }.to change(Comment,:count).by(-1)
      end
    end

    context "user signed in and not comment owner" do
      it "does not delete the comment in the database" do
        comment = create(:comment, book_id: @book.id, user_id: @user.id + 1)
        expect{ delete :destroy, id: comment, book_id: @book, author_id: @book.author }.to_not change(Comment,:count)
      end
    end     
  end

end
