class Adm::Channels::TrusteesController < ApplicationController

  def create
    return redirect_to :root unless current_user && current_user.admin?
    @channel = Channel.find_by_permalink(params[:channel_id])
    @user = User.find(params[:user_id])
    @channel.trustees << @user
    redirect_to adm_users_path
  end

end
