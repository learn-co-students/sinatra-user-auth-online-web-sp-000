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

  # post '/sessions' do
  #   @user = User.find_by(email: params[:email], password: params[:password])
  #   if @user
  #     session[:user_id] = @user.id
  #     redirect '/users/home'
  #   end
  #   redirect '/sessions/login'
  # end

  # get '/users/home' do
  #
  #   @user = User.find(session[:user_id])
  #   erb :'/users/home'
  # end

end
