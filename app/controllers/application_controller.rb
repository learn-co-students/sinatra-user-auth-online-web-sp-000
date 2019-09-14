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

#renders the sign up form
  get '/registrations/signup' do

    erb :'/registrations/signup'
  end

#gets new user info from the params hash.
#creates new user, signs them in and redirects elsewhere.
  post '/registrations' do    #below creates new user
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save    #saves new user
    session[:user_id] = @user.id    #signs in new user

    redirect '/users/home'    #takes user to their homepage
  end

#renders login form
  get '/sessions/login' do

# the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

#receives the post request from login form
#grabs the user info from the params hash.
#looks to match that info against the existing entries in user db.
#if matching entry is found, signs the user in.
  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

#log user out by clearing session hash
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

#renders the user's homepage view.
  get '/users/home' do

    @user = User.find(session[:user_id])
    erb :'/users/home'
  end
end
