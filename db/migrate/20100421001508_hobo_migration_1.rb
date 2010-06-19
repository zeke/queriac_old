class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :user_commands do |t|
      t.string   :name
      t.string   :keyword
      t.text     :url
      t.text     :url_options
      t.text     :description
      t.string   :origin, :default => "hand"
      t.boolean  :url_encode, :default => true
      t.boolean  :public_queries, :default => true
      t.boolean  :http_post, :default => false
      t.boolean  :save_queries, :default => true
      t.boolean  :anonymous_queries, :default => true
      t.integer  :queries_count, :default => 0
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :command_id
    end
    add_index :user_commands, [:command_id]
    add_index :user_commands, [:user_id]

    create_table :queries do |t|
      t.string   :query_string
      t.boolean  :run_by_default, :default => false
      t.text     :referrer
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_command_id
      t.integer  :user_id
    end
    add_index :queries, [:user_id]
    add_index :queries, [:user_command_id]
    add_index :queries, [:created_at]

    create_table :users do |t|
      t.string   :login
      t.string   :email
      t.string   :crypted_password
      t.string   :salt
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :activation_code
      t.datetime :activated_at
      t.string   :first_name
      t.string   :last_name
      t.boolean  :is_admin, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :default_command_id
    end
    add_index :users, [:default_command_id]

    create_table :commands do |t|
      t.string   :name
      t.string   :keyword
      t.text     :url
      t.text     :description
      t.text     :url_options
      t.string   :kind
      t.string   :origin, :default => "hand"
      t.boolean  :public, :default => true
      t.boolean  :bookmarklet, :default => false
      t.boolean  :http_post, :default => false
      t.boolean  :url_encode, :default => true
      t.integer  :users_count, :default => 0
      t.integer  :queries_count_all, :default => 0
      t.datetime :revised_at
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
    end
    add_index :commands, [:user_id]
  end

  def self.down
    drop_table :user_commands
    drop_table :queries
    drop_table :users
    drop_table :commands
  end
end
