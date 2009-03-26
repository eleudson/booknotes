class AuthorsPublications < ActiveRecord::Migration
  def self.up
    create_table :authors_publications, :id => false do |t|
      t.references :author
      t.references :publication
    end
  end

  def self.down
    drop_table :authors_publications
  end
end
