class MenusController < OrderingController
  before_action :load_restaurant, :load_menu
  

  def show
  end


  private
  def load_menu
    @menu = @restaurant.menu
  end

  def load_restaurant
    @restaurant = Restaurant.find( params[ :restaurant_id ])
  end
end
