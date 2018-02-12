class KitchenController < ApplicationController

  def index
    @kitchen = current_user.foods
  end

end
