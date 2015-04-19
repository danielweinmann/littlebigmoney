class Channel < ActiveRecord::Base
  extend CatarseAutoHtml

  attr_accessible :description, :name, :permalink, :email, :twitter, :facebook, :website, :image, :video_url, :how_it_works, :banner_url, :banner_top_url, :banner_bottom_url, :matchfunding_factor, :matchfunding_percentage, :matchfunding_user, :matchfunding_user_id, :matchfunding_maximum, :matchfunding_maximum_per_project, :show_drafts, :legend, :receive_projects, :group_subdomains
  schema_associations

  validates_presence_of :name, :description, :permalink
  validates_uniqueness_of :permalink
  validates :description, length: { maximum: 140 }

  has_and_belongs_to_many :projects,  order: "online_date desc"

  has_and_belongs_to_many :subscribers
  has_and_belongs_to_many :trustees, class_name: :User, join_table: :channels_trustees

  has_many :backers, through: :projects

  belongs_to :matchfunding_user, class_name: :User

  delegate :all, to: :decorator

  catarse_auto_html_for field: :how_it_works, video_width: 600, video_height: 403
  catarse_auto_html_for field: :legend, video_width: 600, video_height: 403

  # Links to channels should be their permalink
  def to_param; self.permalink end
  
  # Using decorators
  def decorator
    @decorator ||= ChannelDecorator.new(self)
  end

  def matchfunding_total
    self.backers.confirmed.matchfunding.where(matchfunding_channel_id: self.id).sum(:value)
  end

  def group_channels
    return unless self.group_subdomains.present?
    subdomains = self.group_subdomains.split(',').map &:strip
    Channel.where(permalink: subdomains)
  end

end
