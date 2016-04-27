class RequestsController < ApplicationController
  before_action :set_request, only: [:destroy]
  before_action :authenticate_user!, only: [:create, :destroy]
  helper_method :book  

  def index
  @requests = current_user.requests
  end 

  def create
    @request = Request.new
    @request.book = book
    @request.user = current_user
    @request.status = 0
    respond_to do |format|
      if @request.save
        format.html { redirect_to [book.author, book] , notice: 'Request was successfully created.' }
      end
    end
  end

  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to user_requests_path(current_user) , notice: 'Comment was successfully destroyed.' }
      format.js
    end
  end

  private
  def set_request
    @request = Request.find(params[:id])
  end

  def book
    @book ||= Book.find(params[:book_id])
  end

end
