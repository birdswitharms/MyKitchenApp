class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:user][:name],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
    )

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:alert] = @user.errors.full_messages
      render :new
    end
  end

  def update
    foods = Food.all

    foods.each do |food|
      param = params[food.name.downcase.to_sym]
      p param

      if param == "1"
        unless current_user.foods.include?(food)
          current_user.foods << food
        end
      end
    end

    p current_user.foods

    redirect_to users_kitchen_path
  end

  def show
    @user = User.find(session[:user_id])
  end

  def kitchen
    @foods = current_user.foods
  end

  def pantry
    @foods = Food.order(:name)
  end

  def shoppinglist
    @list = Shoppinglist.all.where(user: current_user)
  end

  def remove_shoppinglist
    Shoppinglist.all.where(user: current_user).delete_all
    redirect_to root_path
  end

end
