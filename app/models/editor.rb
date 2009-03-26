class Editor < ActiveRecord::Base
  has_many :publications  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_associated :user
  validates_presence_of :user, :user_id
  validates_numericality_of :user_id, :only_integer => true, :greater_than => 0
end
