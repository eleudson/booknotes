class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.references :publication
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
