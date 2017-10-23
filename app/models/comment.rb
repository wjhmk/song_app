class Comment < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :song
  
  has_attached_file :image,
                    :styles => {
                        :thumb  => "180x180",
                        :medium => "400x400",
                        :large => "600x400"
                    },
                    :default_url => "noimage.jpg",
                    :storage => :s3,
                    :s3_permissions => :private,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => ":attachment/:id/:style.:extension"
 
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
 
  def authenticated_image_url(style)
    image.s3_object(style).url_for(:read, :secure => true)
  end
 
  
  validates :body, {presence: true, length: {maximum: 140}}
  
  
  
end


