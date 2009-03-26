class ChangePublicationTypeField < ActiveRecord::Migration
  def self.up
    rename_column :publications, :type, :media
  end

  def self.down
     rename_column :publications, :media, :type
  end
end
