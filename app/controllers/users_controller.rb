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
      redirect "/cars"
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == ""
     redirect to "/signup"
    else
      @user = User.create(username: params[:username], password: params[:password])
       session[:user_id] = @user.id
       redirect "/cars"
     end
   end
 end
