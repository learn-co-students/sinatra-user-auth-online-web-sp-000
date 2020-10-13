class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    @signup = "Sign Up!"
    erb :'home'
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.create(params)
    session[:id] = @user.id

    redirect '/users/home'
  end

  get '/sessions/login' do
    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do
    if @user = User.find_by(email: params["email"], password: params["password"])
      session[:id] = @user.id
    end
      # binding.pry
    if @user
      redirect '/users/home'
    else
      redirect '/sessions/login'
    end
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end
end
