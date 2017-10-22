class Comment < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :song
  
  has_attached_file :image, styles: { :medium => "400x400#", :thumb => "180x180#" }, :default_url => "noimage.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
 
  
  validates :body, {presence: true, length: {maximum: 140}}
  
end


