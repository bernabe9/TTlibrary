class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  helper_method :author

  #GET /books
  def home
    @books = Book.all
  end


  # GET authors/:author_id/books
  def index
    @books = author.books
  end

  # GET authors/:author_id/books/:id
  # GET authors/:author_id/books/:id.json
  def show
    @comments = @book.comments
    if user_signed_in?
      @request = Request.where('book_id' => params[:id], 'user_id' => current_user.id)
    end
    book_author = author.books.pluck(:id).include?(@book.id)
    respond_to do |format|
      if book_author
        format.html { render :show }
        format.json { render json: @book }
      else
        format.html { redirect_to author_books_url }
      end
    end
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/:id/edit
  def edit
  end

  # POST /books
  def create
    @book = author.books.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to [author, @book] , notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: [author, @book] }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/:id
  # PATCH/PUT /books/:id.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to [author, @book], notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/:id
  # DELETE /books/:id.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to author_books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :year, :ISBN)
    end

    def author
      @author ||= Author.find(params[:author_id])
    end
end
