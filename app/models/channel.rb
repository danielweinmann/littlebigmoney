class Channel < ActiveRecord::Base
  extend CatarseAutoHtml

  attr_accessible :description, :name, :permalink, :email, :twitter, :facebook, :website, :image, :video_url, :how_it_works, :banner_url, :matchfunding_factor, :matchfunding_percentage, :matchfunding_user, :matchfunding_user_id
  schema_associations

  validates_presence_of :name, :description, :permalink
  validates_uniqueness_of :permalink

  has_and_belongs_to_many :projects,  order: "online_date desc"

  has_and_belongs_to_many :subscribers
  has_and_belongs_to_many :trustees, class_name: :User, join_table: :channels_trustees

  belongs_to :matchfunding_user, class_name: :User

  delegate :all, to: :decorator

  catarse_auto_html_for field: :how_it_works, video_width: 600, video_height: 403

  # Links to channels should be their permalink
  def to_param; self.permalink end
  
  # Using decorators
  def decorator
    @decorator ||= ChannelDecorator.new(self)
  end
end
