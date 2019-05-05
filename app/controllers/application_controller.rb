class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  ############################## REGISTRATION ################################

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    # instantiate new user
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    # save new user
    @user.save
    # sign user in
    session[:user_id] = @user.id
    # redirect to user home page
    redirect '/users/home'
    # prints out new user params in console
    puts params
  end

  ############################ USER SESSION ################################

  get '/sessions/login' do

    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    # find user by user_params
    @user = User.find_by(email: params[:email], password: params[:password])
    # check to see if user is logged in
    if @user
      # if session user_id matches current user_id
      session[:user_id] = @user.id
      # redirect to current user_id home page
      redirect '/users/home'
    end
    # redirect to log in page
    redirect '/sessions/login'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  ############################### USER HOME ###################################

  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end
end
