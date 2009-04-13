class Note < ActiveRecord::Base
  belongs_to :publication

  validates_associated :publication
  validates_presence_of :publication, :publication_id
  validates_numericality_of :publication_id, :only_integer => true

  validates_presence_of :init_page  
  validates_presence_of :last_page
  validates_presence_of :body

  validates_numericality_of :init_page, :greater_than => 0
  validates_numericality_of :last_page, :greater_than => 0 

  validate :init_page_should_be_less_than_last_page

  protected

  def init_page_should_be_less_than_last_page
    errors.add(:init_page,"Initial page should be less than last page") if (init_page.nil? || last_page.nil?) || (init_page > last_page)
  end
end
