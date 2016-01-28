     
require 'sinatra'
require 'pg'
require 'sinatra/reloader'
require 'pry'



#require 'aws-sdk'

require './db_config'
require './models/dish'
# require './models/dish_type'
require './models/user'
require './models/like'


enable :sessions

helpers do 
  def logged_in?
    !!current_user
  end 

  def current_user
    User.find_by(id: session[:user_id])
  end 
end

#=======home page
get '/' do
	@dishes = Dish.all
  erb :index
end

#===========================MAIN FUNCTIONS
#s=====show the new dish form
get '/dishes/new' do
  @dish = Dish.new
  erb :new
end

#======create a dish
post '/dishes' do
  @dish = Dish.new
  @dish.name = params[:name]
  @dish.user_id = session[:user_id]
  @dish.image = params[:imageFile]

  #@dish.dish_type_id = params[:dish_type_id]
  #if dish save, go to home. If not stay
  if @dish.save
    redirect to '/'
  else
    #@dish_types = DishType.all
    erb :new
  end 
end

#======show a single dish
get '/dishes/:id' do
  @dish = Dish.find(params[:id])
  erb :show
end

#======show the the update dish form
get '/dishes/:id/edit' do
  # sql = 'SELECT * FROM dish_types;'
  # @dish_types = run_sql(sql)
  @dish = Dish.find(params[:id])
  erb :edit
end

#=====update an existing dish
put '/dishes/:id' do
  @dish = Dish.find(params[:id])
  @dish.name = params[:name]
  @dish.image = params[:imageFile]
  #@dish.dish_type_id = params[:dish_type_id]
  @dish.save
  # redirect to another page with a get request
  redirect to "/dishes/#{ params[:id] }"
end

#=====delete a dish
delete '/dishes/:id' do
  @dish = Dish.find(params[:id])
  @dish.destroy
  redirect to '/'
end

#========================like a dish/unlike
post '/like/:id' do
  like = Like.new
  like.user_id = current_user.id
  like.dish_id = params[:id]
  if like.save
      redirect to '/'
  end 
end 

delete '/likes' do
  likes = Like.where(user_id: current_user.id, dish_id: params[:dish_id])
  likes.each do |like|
    like.destroy
  end 
  redirect to '/'
end

#===============================AUTHENTICATION
#===========show the login form
get '/session/new' do
  erb :login
end 


#===========login
post '/session' do
  'logging in'
  #1 - search for the user
  user = User.find_by(email: params[:email])

  #2 - authenticate password
  if user && user.authenticate(params[:password])
    #3 - create a session - enable Sessions up the top - sinatra feature
    # - 'session[:user_id] is new variable'
    session[:user_id] = user.id
    
    #4 - redirect to home
    redirect to '/'

  else
    #stay at login form if unsuccessful
    erb :login
  end 
end 

#========logout
delete '/session' do

  session[:user_id] = nil
  redirect to '/'
end 

#========new user form
get '/user/new' do
	#@user = User.new 
	erb :signup
end

post '/users' do
  @user = User.new
  @user.name = params[:name]
  @user.email = params[:email]
  @user.password = params[:password]
  if @user.save
  	#sign straight in and return home
  	user = User.find_by(email: params[:email])
  	session[:user_id] = user.id
    redirect to '/'
  else
    erb :signup
  end 
end


#=========IMAGES
# s3 = Aws::S3::Resource.new(region: 'ap-southeast-2')
# obj = s3.bucket('gruelintentions').object("your key - basically it's the name of your image")
# obj.upload_file("file - this should be the complete, acl:'public-read")
# url = obj.public_url will give the url for you to access later or store it to your database.






