class UsersController < ApplicationController

  get "/users/:id" do
    if !logged_in?
      redirect to "/login"
    end
    @user = User.find_by_id(params[:id])
    if !@user.nil? && @user == current_user
      erb :"/users/show"
    else
      redirect to "/login"
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
      @user.save
      redirect to "/users/#{@user.id}"
    end
  end

  get "/login" do
    if !session[:user_id]
      erb :"/users/login"
    else
      redirect to "/signup"
    end
  end

  post "/login" do
    user = User.find_by(username: params["username"])
    if user && user.authenticate(params["password"])
      session[:user_id] = user.id
      user.save
      redirect to "/users/#{user.id}"
    else
      redirect to "/signup"
    end
  end

  get "/logout" do
    if session[:user_id] != nil
      session.destroy
      redirect to "/login"
    else
      redirect to "/"
    end
  end
end
