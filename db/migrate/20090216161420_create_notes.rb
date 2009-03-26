class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.references :publication
      t.string :name
      t.integer :init_page
      t.integer :last_page
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
