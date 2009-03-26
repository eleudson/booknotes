class Review < ActiveRecord::Base
  belongs_to :publication

  validates_associated :publication
  validates_presence_of :publication, :publication_id
  validates_numericality_of :publication_id, :only_integer => true

  validates_presence_of :body
end
