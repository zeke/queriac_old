# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'


namespace :import do
  
  desc "Import queries from old database"
  task(:old_queries => :environment) do
    
    path = "#{RAILS_ROOT}/db/old_queries.csv"
    grants = CsvMapper.import(path) do
      read_attributes_from_file
      map_to Query
      
      after_row lambda { |row, query|
        query.id = nil
        query.query_string = query.query_string.gsub("DBQ", '"')
        puts query.query_string unless query.query_string.blank?
        query.save!
      }
    end
  end # task
end