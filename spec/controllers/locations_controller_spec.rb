require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  describe "locations#create action" do
    it "should allow users to create locations on wows" do
      wow = FactoryBot.create(:wow)

      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { wow_id: wow.id, location: { comment: 'awesome wow' } }
      expect(response).to redirect_to root_path
      expect(wow.locations.length).to eq 1
      expect(wow.locations.first.comment).to eq "awesome wow"
    end

    it "should require a user to be logged in to provide a location on a wow" do
      wow = FactoryBot.create(:wow)
      post :create, params: { wow_id: wow.id, location: { comment: 'awesome wow' } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should return http status code of not found if the wow isn't found" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: { wow_id: 'YOLOSWAG', location: { comment: 'awesome wow' } }
      expect(response).to have_http_status :not_found
    end
  end
end
