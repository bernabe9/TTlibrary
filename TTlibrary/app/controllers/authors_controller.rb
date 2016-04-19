class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  #GET /authors
  def index
    @authors = Author.all
  end

  # GET /authors/new
    def new
      @author = Author.new
    end

  # POST /authors
  def create
  @author = Author.new(author_params)

  respond_to do |format|
    if @author.save
      format.html { redirect_to @author, notice: 'Author was successfully created.' }
      format.json { render :show, status: :created, location: @author }
    else
      format.html { render :new }
      format.json { render json: @author.errors, status: :unprocessable_entity }
    end
  end
  end

  # PATCH/PUT /authors/:id
  def update
  respond_to do |format|
    if @author.update(author_params)
      format.html { redirect_to @author, notice: 'Author was successfully updated.' }
      format.json { render :show, status: :ok, location: @author }
    else
      format.html { render :edit }
      format.json { render json: @author.errors, status: :unprocessable_entity }
    end
  end
  end

  # DELETE /authors/:id
  def destroy
  @author.destroy
  respond_to do |format|
    format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
    format.json { head :no_content }
  end
  end

  # GET /authors/:id
  def show
  end

  # GET /authors/:id/edit
  def edit
  end

  private
    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
        params.require(:author).permit(:first_name, :last_name)
      end
end
