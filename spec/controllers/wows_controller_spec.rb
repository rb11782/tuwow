require 'rails_helper'

RSpec.describe WowsController, type: :controller do
  describe "wows#update action" do
    it "should allow users to successfully update wows" do
      wow = FactoryBot.create(:wow, comment: "Initial Value")
      patch :update, params: { id: wow.id, wow: { comment: 'Changed' } }
      expect(response).to redirect_to root_path
      wow.reload
      expect(wow.comment).to eq "Changed"
    end

    it "should have http 404 error if the wow cannot be found" do
      patch :update, params: { id: "YOLOSWAG", wow: { comment: 'Changed' } }
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      wow = FactoryBot.create(:wow, comment: "Initial Value")
      patch :update, params: { id: wow.id, wow: { comment: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      wow.reload
      expect(wow.comment).to eq "Initial Value"
    end
  end
  



  describe "wows#edit action" do
    it "should successfully show the edit form if the wow is found" do
      wow = FactoryBot.create(:wow)
      get :edit, params: { id: wow.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the wow is not found" do
      get :edit, params: { id: 'SWAG' }
      expect(response).to have_http_status(:not_found)
    end
  end



  describe "wows#show action" do
    it "should successfully show the page if the wow is found" do
      wow = FactoryBot.create(:wow)
      get :show, params: { id: wow.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the wow is not found" do
      get :show, params: { id: 'TACOCAT' }
  expect(response).to have_http_status(:not_found)
    end
  end


  describe "wows#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


  describe "wows#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end


    it "should successfully show the new form" do
      user = FactoryBot.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "wows#create action" do
    it "should require users to be logged in" do
      post :create, params: { wow: { comment: "Look at This!" } }
      expect(response).to redirect_to new_user_session_path
    end


    it "should successfully create a new wow in our database" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { wow: { comment: 'Look at This!' } }
      expect(response).to redirect_to root_path

      wow = Wow.last
      expect(wow.comment).to eq("Look at This!")
      expect(wow.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user

      wow_count = Wow.count
      post :create, params: { wow: { comment: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(wow_count).to eq Wow.count
    end

  end
  
end
