class Adm::Channels::ProjectsController < ApplicationController

  def create
    return redirect_to :root unless current_user && current_user.admin?
    @channel = Channel.find_by_permalink(params[:channel_id])
    @project = Project.find(params[:project_id])
    @channel.projects << @project
    redirect_to adm_projects_path
  end

end
