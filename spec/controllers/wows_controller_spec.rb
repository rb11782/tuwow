require 'rails_helper'

RSpec.describe WowsController, type: :controller do
  describe "wows#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


  describe "wows#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "wows#create action" do
    it "should successfully create a new wow in our database" do
      post :create, params: { wow: { comment: 'Look at This!' } }
      expect(response).to redirect_to root_path

      wow = Wow.last
      expect(wow.comment).to eq("Look at This!")
    end

    it "should properly deal with validation errors" do
      post :create, params: { wow: { comment: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Wow.count).to eq 0
    end

  end
  
end
