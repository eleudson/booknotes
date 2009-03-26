class CreatePublications < ActiveRecord::Migration
  def self.up
    create_table :publications do |t|
      t.references :editor
      t.string :title
      t.string :isbn
      t.string :source
      t.string :type
      t.string :idiom
      t.string :license

      t.timestamps 
    end
  end

  def self.down
    drop_table :publications
  end
end
