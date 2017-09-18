class Order::PreferencesController < ApiController
  before_action  :require_login, :load_order_preference

  def update
     if(order_preference_params.permitted?)
       #p "ord => #{order_preference_params}"
       #p "ordr => #{@order_preference.to_json}"
       if(@order_preference.update(order_preference_params))
         render json: @order_preference and return
       end
     end
     render json: @order_preference.errors, status: :unprocessable_entity
    
  end

  private 
  def load_order_preference
    @order_preference = current_user.order_preference
  end
  def order_preference_params
    params.require(:order_preference).permit(:type)
  end
end
