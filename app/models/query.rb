class Query < ActiveRecord::Base
  
  fields do
    user_id :integer, :index => true
    user_command_id :integer, :index => true
    query_string :string
    run_by_default :boolean, :default => false
    referrer :text
    created_at :datetime, :index => true
    updated_at :datetime
  end

  belongs_to :user_command
  belongs_to :user
  has_many :tags, :through => :user_command

  named_scope :public, :conditions => ["user_commands.public_queries = 1"]
  named_scope :non_empty, :conditions => ["LENGTH(query_string) > 0"]
  named_scope :three_months_or_older, :conditions => ['queries.created_at < ?', 3.months.ago]
  named_scope :any

  def command
    user_command.command
  end
  
  def after_create
    if self.user_command
      self.user_command.update_query_counts
      self.user_command.command.increment_query_count if self.user_command.command
    end
  end
  
end
