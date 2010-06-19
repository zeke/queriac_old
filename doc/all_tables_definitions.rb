  # commands
  # ------------------------------------------------------------

    # create_table :bozos do |t|
    #   t.string :name
    #   t.integer :age
    # 
    #   t.timestamps
    # end

  fields do
    user_id :integer
    name :string
    keyword :string
    url :text
    description :text
    url_options :text
    kind :string
    origin :string, :default => 'hand'
    public :boolean, :default => true
    bookmarklet :boolean, :default => false
    http_post :boolean, :default => false
    url_encode :boolean, :default => true
    users_count :integer, :default => 0
    queries_count_all :integer, :default => 0
    revised_at :datetime
    timestamps
  end

  # queries
  # ------------------------------------------------------------

  fields do
    user_id :integer, :index => true
    user_command_id :integer, :index => true
    query_string :string
    run_by_default :boolean, :default => false
    referrer :text
    created_at :datetime, :index => true
    updated_at :datetime
  end


  # taggings
  # ------------------------------------------------------------

  fields do
    tag_id :integer, :default => 0, :index => true
    taggable_id :integer, :default => 0, :index => true
    taggable_type :string, :default => '', :index => true
  	timestamps
  end


  # tags
  # ------------------------------------------------------------

  fields do
    name :string, :default => '', :index => true
    description :string
  	timestamps
  end


  # user_commands
  # ------------------------------------------------------------

  fields do
    command_id :integer, :index => true
    user_id :integer, :null => false
    name :string
    keyword :string
    url :text
    url_options :text
    description :text
    origin :string, :default => 'hand'
    url_encode :boolean, :default => true
    public_queries :boolean, :default => true
    http_post :boolean, :default => false
    save_queries :boolean, :default => true
    anonymous_queries :boolean, :default => true
    queries_count :integer, :default => 0
  	timestamps
  end

  # users
  # ------------------------------------------------------------

  fields do
    login :string
    email :string
    crypted_password :string
    salt :string
    remember_token :string
    remember_token_expires_at :datetime
    activation_code :string
    activated_at :datetime
    default_command_id :integer
    first_name :string
    last_name :string
    is_admin :boolean, :default => false
  	timestamps
  end