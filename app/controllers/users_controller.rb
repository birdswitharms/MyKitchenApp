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

  def update_appliances
    # <%= form_tag users_kitchen_path(@users), method: :patch do %>
    appliances = Appliance.all

    appliances.each do |appliance|
      param = params[appliance.name.downcase.to_sym]

      if param == "1"
        unless current_user.appliances.include?(appliance)
          current_user.appliances << appliance
        end
      end
    end

    p current_user.appliances

    redirect_to users_kitchen_path
  end

  def show
    @user = User.find(session[:user_id])
    @history = current_user.histories.all
  end

  def kitchen
    @foods = current_user.foods
    @appliances = current_user.appliances
  end

  def pantry
    @foods = Food.order(:name)
  end

  def appliances
    # showing all appliances, can narrow down to unowned
    @appliances = Appliance.order(:name)
    render :my_appliances
  end

  def favorites
    @favorites = []
    Favorite.where(user: current_user).each { |favorite|
      ap favorite.recipe
      @favorites << favorite.recipe
    }
  end

  def shoppinglist
    @list = Shoppinglist.all.where(user: current_user)
  end

  def remove_shoppinglist
    Shoppinglist.all.where(user: current_user).delete_all
    redirect_to root_path
  end

end
