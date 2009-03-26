class AddUserId < ActiveRecord::Migration
  def self.up
    add_column :authors, :user_id, :integer
    add_column :editors, :user_id, :integer
    add_column :publications, :user_id, :integer
  end

  def self.down
    remove_column :authors, :user_id
    remove_column :editors, :user_id
    remove_column :publications, :user_id
  end
end
