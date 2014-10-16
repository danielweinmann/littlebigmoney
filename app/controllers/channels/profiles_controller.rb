class Channels::ProfilesController < Channels::BaseController
  inherit_resources
  defaults resource_class: Channel, finder: :find_by_permalink! 
  actions :show
  custom_actions resource: [:how_it_works]

  before_filter{ params[:id] = request.subdomain }

  def show
    show! do
      @projects = @profile.projects.visible_or_draft
      @projects = @projects.visible unless @profile.show_drafts?
    end
  end

end
