class KitchenController < ApplicationController

  def index
    @kitchen = current_user.foods
  end

  def edit
    @food = Food.all
    @kitchen = Kitchen.find(params[:id])
  end

  def update
    @kitchen = Kitchen.find(params[:id])
    foods = Food.all

    foods.each do |food|
      param = params[food.name.downcase.to_sym]
      p param

      if param == "1"
        unless @kitchen.foods.include?(food)
          @kitchen.foods << food
        end
      end
    end

    p @kitchen.foods

    redirect_to kitchen_index_path(@kitchen)
  end

end
