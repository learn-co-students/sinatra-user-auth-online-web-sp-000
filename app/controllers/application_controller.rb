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

  get '/registrations/signup' do #route has one responsibility: render the sign-up form view. 

    erb :'/registrations/signup'
  end

  post '/registrations' do #route is responsible for handling the POST request that is sent when a user hits 'submit' on the sign-up form. It will contain code that gets the new user's info from the params hash, creates a new user, signs them in, and then redirects them somewhere else.
    puts params
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])# this line of code registered a new user
    @user.save
    session[:user_id] = @user.id #sign user in

    redirect '/users/home' #Now that we've signed up and logged in our user, we want to take them to their homepage.
  end

  get '/sessions/login' do #route is responsible for rendering the login form.

    # the line of code below render the view page in app/views/sessions/login.erb
    erb :'sessions/login'
  end

  post '/sessions' do 
    #route is responsible for receiving the POST request that gets sent when a user hits 'submit' on the login form. 
    # This route contains code that grabs the user's info from the params hash, looks to match that info against the
    # existing entries in the user database, and, if a matching entry is found, signs the user in.
    puts params
    @user = User.find_by(email: params[:email], password: params[:password])# lines of code that will find the correct user from the database
    if @user
      session[:user_id] = @user.id #log them in by setting the session[:user_id] equal to their user ID
      redirect '/users/home'
    end
    redirect '/sessions/login'
  end

  get '/sessions/logout' do #route is responsible for logging the user out by clearing all of the data from the session hash
    session.clear
    redirect '/'
  end

  get '/users/home' do #route is responsible for rendering the user's homepage view.
    # this route finds the current user based on the ID value stored in the session hash.
    # Then, it sets an instance variable, @user, equal to that found user, allowing us to
    # access the current user in the corresponding view page.
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end
end
