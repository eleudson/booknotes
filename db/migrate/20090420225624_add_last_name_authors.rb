class AddLastNameAuthors < ActiveRecord::Migration
  def self.up
    add_column :authors, :last_name, :string

    Author.reset_column_information
    Author.find(:all).each do |p| 
      a = p.name.split
      p.update_attribute :last_name, a.last
      p.update_attribute :name, a[0..-2].join(" ")
    end
  end

  def self.down
    Author.find(:all).each do |p| 
      p.update_attribute :name, "#{p.name} #{p.last_name}"
    end
    remove_column :authors, :last_name
  end
end
