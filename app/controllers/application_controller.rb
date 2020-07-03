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

#render the sign up form view signup.erb
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

#handing the POST request that is sent when the user hits submit on the sign up form.
#contain code that gets new users info from the params hash, creates a new user, signs them in, and then redirects them somewhere else.
  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:user_id] = @user.id
    redirect '/users/home'
  end

#rendering the login form
  get '/sessions/login' do
    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

#receiving the post request that gets sent when a user hits submit.
#contains code that grabs the users info from the params hash, looks to see if user is in database, and signs user in if matched.
  post '/sessions' do
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end 

#logging the user out by clearing the session hash.
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

#rendering the users homepage view.
  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end

end
