class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy, :edit, :update, :user_owner?] 
  before_action :authenticate_user!, only: [:edit, :create, :destroy, :update]
  before_action :user_owner?, only: [:destroy, :edit, :update]
  

  helper_method :book  

  def index
    @comments = book.comments
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.book = book
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to [book.author, book] , notice: 'Comment was successfully created.' }
      else
        format.html { render :index }
      end
      format.js
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to [book.author, book] , notice: 'Comment was successfully destroyed.' }
      format.js
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [book.author, book, @author], notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def book
    @book ||= Book.find(params[:book_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :rate)
  end

  def user_owner?
    if @comment.user == current_user
      true
    else
      redirect_to [book.author, book] , notice: 'Unauthorised access'
    end
  end

end
