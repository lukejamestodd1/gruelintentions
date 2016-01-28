require 'pry'
require 'active_record'
#somewhere in active record bcryt is written

#TO GIVE MORE INFO - shows the SQL generated and other stuff
ActiveRecord::Base.logger = Logger.new(STDERR)

require './db_config'
require './models/dish'
require './models/user'
require './models/like'

binding.pry



