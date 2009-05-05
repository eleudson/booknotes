class AddCityToEditors < ActiveRecord::Migration
  def self.up
    add_column :editors, :city, :string
  end

  def self.down
    remove_column :editors, :city
  end
end
