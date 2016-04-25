require "spec_helper"
require "rails_helper"

describe AuthorsController do
  describe "GET #index" do
    it "populates an array of authors" do
      author = create(:author)
      get :index
      expect(assigns(:authors)).to eq([author])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  
  describe "GET #show" do
    it "assigns the requested author to @author" do
      author = create(:author)
      get :show, id: author
      expect(assigns(:author)).to eq(author)
    end

    it "renders the :show template" do
      get :show, id: create(:author)
      response.should render_template :show
    end
  end
  
  describe "GET #new" do
    it "assigns a new author to @author" do
      get :new
      expect(assigns(:author)).to be_a_new(Author)
    end
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new author in the database" do
        expect{ post :create, author: attributes_for(:author) }.to change(Author,:count).by(1)
      end
      it "redirects to the show author" do
        get :show, id: create(:author)
        response.should render_template :show
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new author in the database" do
         expect{ post :create, author: attributes_for(:author, first_name: nil) }.to_not change(Author,:count)
         expect{ post :create, author: attributes_for(:author, last_name: nil) }.to_not change(Author,:count)
      end
      it "re-renders the :new template" do
        get :new
        response.should render_template :new
      end
    end
  end

  describe 'PUT update' do
    before { @author = create(:author) }
    
    context "valid attributes" do
      it "located the requested @author" do
        put :update, id: @author, author: attributes_for(:author)
        assigns(:author).should eq(@author)      
      end
    
      it "changes @author's attributes" do
        put :update, id: @author, 
          author: attributes_for(:author, first_name: "Larry", last_name: "Smith")
        @author.reload
        @author.first_name.should eq("Larry")
        @author.last_name.should eq("Smith")
      end
    
      it "redirects to the updated author" do
        put :update, id: @author, author: attributes_for(:author)
        response.should redirect_to @author
      end
    end
    
    context "invalid attributes" do
      it "locates the requested @author" do
        put :update, id: @author, author: attributes_for(:author)
        assigns(:author).should eq(@author)      
      end
      
      it "does not change @author's attributes" do
        put :update, id: @author, 
          author: attributes_for(:author, first_name: "Larry", last_name: nil)
        @author.reload
        @author.first_name.should_not eq("Larry")
      end
      
      it "re-renders the edit method" do
        put :update, id: @author, author: attributes_for(:author, first_name: nil)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
  before { @author = create(:author) }
    
    it "deletes the author" do
      expect{
        delete :destroy, id: @author        
      }.to change(Author,:count).by(-1)
    end
      
    it "redirects to authors#index" do
      delete :destroy, id: @author
      response.should redirect_to authors_url
    end
  end
end
