class CarsController < ApplicationController

  get "/cars" do
    redirect_if_not_logged_in
    @cars = Car.all
    erb :"/cars/index"
  end

  get "/cars/new" do
    redirect_if_not_logged_in

    erb :"/cars/new"
  end

  get "/cars/:id/edit" do
    redirect_if_not_logged_in
    @car = Car.find_by_id(params[:id])
    erb :"/cars/edit"
  end

  post "/cars/:id" do
    redirect_if_not_logged_in
    if params["make"] == "" || params["name"] == "" || params["year"] == "" || params["user_id"] == ""
      redirect to "/cars/#{@car.id}/edit"
    else
      @car = Car.find_by_id(params[:id])
      @car.update(make: params["make"], name: params["name"], year: params["year"], user_id: params["user_id"])
      redirect to "/cars/#{@car.id}"
    end
  end

  get "/cars/:id" do
    redirect_if_not_logged_in
    @car = Car.find_by_id(params[:id])
    erb :"/cars/show"
  end

  post "/cars" do
    redirect_if_not_logged_in
    if params["make"] == "" || params["name"] == "" || params["year"] == "" || params["user_id"] == ""
      redirect to "/cars/new"
    else
      Car.create(make: params["make"], name: params["name"], year: params["year"], user_id: params["user_id"])
      redirect to "/cars"
    end
  end
end
