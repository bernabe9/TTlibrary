require "spec_helper"
require "rails_helper"

describe AuthorsController do
  let(:author) { create(:author) }

  describe "GET #index" do
    it "populates an array of authors" do
      get :index
      expect(assigns(:authors)).to eq([author])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end
  
  describe "GET #show" do
    it "assigns the requested author to @author" do
      get :show, id: author
      expect(assigns(:author)).to eq(author)
    end

    it "renders the :show template" do
      get :show, id: create(:author)
      expect(response).to render_template(:show)
    end
  end
  
  describe "GET #new" do
    it "assigns a new author to @author" do
      get :new
      expect(assigns(:author)).to be_a_new(Author)
    end
    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new author in the database" do
        expect{ post :create, author: attributes_for(:author) }.to change(Author,:count).by(1)
      end
      it "redirects to the show author" do
        get :show, id: author
        expect(response).to render_template(:show)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new author in the database" do
         expect{ post :create, author: attributes_for(:author, first_name: nil) }.to_not change(Author,:count)
         expect{ post :create, author: attributes_for(:author, last_name: nil) }.to_not change(Author,:count)
      end
      it "re-renders the :new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT update' do
    it "located the requested @author" do
      put :update, id: author, author: attributes_for(:author)
      expect(assigns(:author)).to eq(author)      
    end
    
    context "valid attributes" do    
      it "changes @author's attributes" do
        put :update, id: author, 
          author: attributes_for(:author, first_name: "Larry", last_name: "Smith")
        author.reload
        expect(author.first_name).to eq("Larry")
        expect(author.last_name).to eq("Smith")
      end
    
      it "redirects to the updated author" do
        put :update, id: author, author: attributes_for(:author)
        expect(response).to redirect_to(author)
      end
    end
    
    context "invalid attributes" do
      it "does not change @author's attributes" do
        put :update, id: author, 
          author: attributes_for(:author, first_name: "Larry", last_name: nil)
        author.reload
        expect(author.first_name).not_to eq("Larry")
      end
      
      it "re-renders the edit method" do
        put :update, id: author, author: attributes_for(:author, first_name: nil)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:author) { create(:author) }

    it "deletes the author" do
      expect{ delete :destroy, id: author }.to change(Author,:count).by(-1)
    end
      
    it "redirects to authors#index" do
      delete :destroy, id: author
      expect(response).to redirect_to(authors_url)
    end
  end

end
