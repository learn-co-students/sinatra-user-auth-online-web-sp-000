class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end



  get '/' do #this URL ending will pull up this ERB page
    erb :home
  end
  #should render the app/views/home.erb page
  #renders our homepage
  # 4)


  get '/registrations/signup' do #this URL ending, will pull up the ERB page below
    erb :'/registrations/signup'
  end
  #NEW
  #responsible for rendering the sign-up template
  # 6)

  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id # 10)
    redirect '/users/home' #takes user to their homepage
  end
  #CREATE
  #post data to the /registrations path
  #assigned the users input to an instance of the user aka made user object aka "signed the user in"
  # 9)



  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    @user = User.find_by(email: params["email"], password: params["password"])
    if @user
    session[:id] = @user.id
    redirect '/users/home'
    end
    redirect '/sessions/login'
  end
  #receives the user input and assigns the session to a user


  get '/sessions/logout' do
    session.clear 
    redirect '/'
  end


  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end
