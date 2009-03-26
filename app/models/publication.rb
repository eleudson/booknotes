class Publication < ActiveRecord::Base
  belongs_to :editor
  has_one :review, :dependent => :destroy
  has_and_belongs_to_many :authors

  has_many :notes, :dependent => :destroy
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"

  MEDIAS = [['Book','BOOK'],
            ['Cd','CD'],
            ['Dvd','DVD'],
            ['Article','ARTICLE'],
            ['WebPage','WEBPAGE'],
            ['Blog Post','BLOG_POST'],
            ['Screencast','SCREENCAST'],
            ['Podcast','PODCAST']
           ].sort

  validates_associated :editor, :user
  validates_presence_of :editor, :editor_id, :user, :user_id

  validates_presence_of :title
  validates_presence_of :idiom
  validates_presence_of :license
  validates_presence_of :media

  validates_uniqueness_of :title
  validates_numericality_of :editor_id, :only_integer => true, :greater_than => 0
  validates_numericality_of :user_id, :only_integer => true, :greater_than => 0
end
