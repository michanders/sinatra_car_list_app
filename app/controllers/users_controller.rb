class UsersController < ApplicationController

  get "/users/:id" do
    if logged_in?
      @user = User.find_by_id(params[:id])
      if @user == current_user && @user != nil
        erb :"/users/show"
      end
    else
      redirect "/login"
    end
  end

  get "/signup" do
    if !session[:user_id]
      erb :"/users/new"
    else
      redirect to "/users/:id"
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == ""
     redirect to "/signup"
    else
      @user = User.create(username: params["username"], password: params["password"])
       session[:user_id] = @user.id
       redirect to "/users/:id"
     end
   end

  get "/login" do
    if session[:user_id] != nil
      erb :"/users/login"
    else
      redirect to "/signup"
    end
  end

  post "/login" do
    user = User.find_by(:username => params["username"])
    if user && user.authenticate(params["password"])
      session[:user_id] = user.id
      redirect to "/users/:id"
    else
      redirect to "/signup"
    end
  end
end
