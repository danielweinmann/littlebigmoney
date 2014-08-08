class Adm::ChannelsController < Adm::BaseController

  menu I18n.t("adm.channels.index.menu", locale: :es) => Rails.application.routes.url_helpers.adm_channels_path(locale: :es)

  before_filter do
    @total_channels = Channel.count
  end

  before_filter(only: [:update, :edit]) do
    @channel = Channel.find_by_permalink(params[:id])
  end

  before_filter :set_title

  def create
    create! { adm_channels_path }
  end

  def update
    update! { adm_channels_path }
  end

  protected

  def set_title
    @title = t("adm.channels.index.title")
  end

  def collection
    @channels = end_of_association_chain.page(params[:page])
  end

end
