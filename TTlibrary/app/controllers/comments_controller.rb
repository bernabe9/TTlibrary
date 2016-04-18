class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy, :edit, :update] 

  helper_method :book

  def index
    @comments = book.comments
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.book = book
    respond_to do |format|
      if @comment.save
        format.html { redirect_to [book.author, book] , notice: 'Comment was successfully created.' }
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
    params.require(:comment).permit(:text)
  end

end
