require "spec_helper"
require "rails_helper"

describe RequestsController do
  let(:request) { create(:request) }

  describe "GET #index" do
    before { sign_in request.user }

    it "populates an array of user's requests" do
      get :index, user_id: request.user
      expect(assigns(:requests)).to eq([request])
    end

    it "renders the :index view" do
      get :index, user_id: request.user
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    context "user signed in" do
      before { sign_in request.user}
      it "saves the new request in the database" do
        expect{ post :create, request: attributes_for(:request), user_id: request.user, book_id: request.book }.to change(Request,:count).by(1)
      end
    end

    context "user not signed in" do
      let!(:request) { create(:request) }
      it "does not save the new request in the database" do
        expect{ post :create, request: attributes_for(:request), user_id: request.user, book_id: request.book }.to_not change(Request,:count)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:request) { create(:request) } 
    
    context "user signed" do
      it "deletes the request" do
        sign_in request.user
        expect{ delete :destroy, id: request, book_id: request.book, user_id: request.user }.to change(Request,:count).by(-1)
      end
    end

    context "user not signed" do
      it "does not delete the request in the database" do
        expect{ delete :destroy, id: request, book_id: request.book, user_id: request.user }.to_not change(Request,:count)
      end
    end    
  end

end
