class LocationsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @wow = Wow.find_by_id(params[:wow_id])
    return render_not_found if @wow.blank?

    @wow.locations.create(location_params.merge(user: current_user))
    redirect_to root_path
  end

  private

  def location_params
    params.require(:location).permit(:comment)
  end


end
