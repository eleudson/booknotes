class AddFiedlsPublication < ActiveRecord::Migration
  def self.up
    add_column :publications, :issue, :string
    add_column :publications, :volume, :string
    add_column :publications, :publication_date, :string
  end

  def self.down
    remove_column :publications, :issue
    remove_column :publications, :volume
    remove_column :publications, :publication_date
  end
end
