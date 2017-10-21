class Song < ActiveRecord::Base
    acts_as_votable
    belongs_to :user
    has_many :comments, :dependent => :destroy
    
    validates :title, {presence: true, length: {maximum: 140}}
    validates :body, {presence: true}
    validates :singer, {presence: true}
    
    scope :like, ->{order(:cached_votes_up => :desc)}
    scope :latest, ->{order("created_at desc")}
    
end
