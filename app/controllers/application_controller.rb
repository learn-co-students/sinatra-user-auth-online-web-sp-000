class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do # this route renders the app/views/home.erb file
    erb :home
  end

  get '/registrations/signup' do # this route renders the sign-up form view app/views/registrations/signup.erb

    erb :'/registrations/signup'
  end

  post '/registrations' do # this route handles the POST request that is sent when a user hits 'submit' on the sign-up form.
    # gets the new user's info from the params hash, creates a new user, signs them in, and then redirects them somewhere else.
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id
    puts params # outputs our params hash to the terminal
    redirect '/users/home'
  end

  get '/sessions/login' do # this route is responsible for rendering the login form.

    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do # this route is responsible for receiving the POST request that gets sent when a user hits 'submit' on the login form.
    # grabs the user's info from the params hash, looks to match that info against the existing entries in the user database, and, if a matching entry is found, signs the user in.
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    puts params
    redirect '/sessions/login'
  end

  get '/sessions/logout' do # this route is responsible for loggins the user out by clearing the session hash.
    session.clear
    redirect '/'
  end

  get '/users/home' do # this route is responsible for rendering the user's homepage view.

    @user = User.find(session[:user_id])
    erb :'/users/home'
  end
end
