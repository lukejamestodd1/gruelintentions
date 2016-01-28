require 'active_record'

options = {
	adapter: 'postgresql',
	database: 'gruelintentions'
}
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || options)
#to do with deployment