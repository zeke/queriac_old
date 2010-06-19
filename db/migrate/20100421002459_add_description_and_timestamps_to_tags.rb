class AddDescriptionAndTimestampsToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :description, :string
    add_column :tags, :created_at, :datetime
    add_column :tags, :updated_at, :datetime
  end

  def self.down
    remove_column :tags, :description
    remove_column :tags, :created_at
    remove_column :tags, :updated_at
  end
end
