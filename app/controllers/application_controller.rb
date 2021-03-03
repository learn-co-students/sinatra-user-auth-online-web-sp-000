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

  get '/registrations/signup' do
    #render the sign-up form view
    erb :'/registrations/signup'
  end

  post '/registrations' do
    #creates a new user
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    puts params

    #signs them in
    session[:user_id] = @user.id

    #brings them to home page
    redirect '/users/home'
  end

  get '/sessions/login' do

    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    #if the user is found, signs them in, else goes back to login page
    puts params
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  get '/users/home' do

    @user = User.find(session[:user_id])
    erb :'/users/home'
  end
end
