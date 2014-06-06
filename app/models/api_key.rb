class ApiKey < ActiveRecord::Base
  belongs_to :user
  attr_accessible :access_token, :expires_at, :user_id
  validates_presence_of :user
  validates_uniqueness_of :access_token

  before_create :set_access_token

  def self.not_expired
    where("expires_at < current_timestamp OR expires_at IS NULL")
  end

  private

  def set_access_token
    return if self.access_token.present?
    token = SecureRandom.hex
    while self.class.exists?(access_token: token) do
      token = SecureRandom.hex
    end
    self.access_token = token
  end

end
