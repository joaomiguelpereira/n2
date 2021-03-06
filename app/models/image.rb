require 'open-uri'

class Image < ActiveRecord::Base

  acts_as_moderatable
  acts_as_voteable

  belongs_to :user
  belongs_to :imageable, :polymorphic => true

  has_attached_file :image, :styles => {
  	:mini => "50x50",
  	:thumb => "100x100>",
  	:small => "180x180>",
  	:medium => "200x200"
  }

  before_validation :download_image, :if => :remote_image_url?
  validates_presence_of :remote_image_url, :allow_blank => true, :message => 'invalid image or url.', :if => :remote_image_url?
  validates_presence_of :image, :image_file_name, :image_content_type, :image_file_size

  after_validation :set_user

  delegate :url, :to => :image

  private

  def set_user
    self.user = current_user unless self.user.present?
  end

  def download_image
    self.image = open(URI.parse(remote_image_url))
  end

end
