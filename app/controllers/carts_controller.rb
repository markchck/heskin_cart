class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = current_user.carts
  end

  def create
    
    remain_cart= current_user.carts.find_by(pack_id: params[:pack_id])
    
    if remain_cart.present?
    
      remain_cart.update(quantity: (params[:quantity].to_i + remain_cart.quantity))
      # current_user.carts.update(quantity: params[:quantity] + current_user.carts.quantity)
      #remain_cart.quantity.update(params[:quantity].to_i + remain_cart.quantity.to_i)
      
      puts "hiih"
      puts remain_cart.quantity

      
    else
      Cart.create(
        pack_id: params[:pack_id],
        
        user_id: current_user.id,
        quantity: params[:quantity]
        )
    end
      
    # cart = Cart.new(
    #   pack_id: params[:pack_id],
    #   user_id: current_user.id,
    #   quantity: params[:quantity]
    # )
    
    # remain_cart = current_user.carts.find_by(pack_id: params[:pack_id])
 
    # if remain_cart.present?
    #   sum_quantity =  remain_cart.quantity + params[:quantity].to_i
    #   remain_cart.update(quantity: sum_quantity)
    # else
    #   cart.save
    # end

    flash[:notice] = "성공적으로 등록 되었습니다. 장바구니로 이동하시겠습니까?"
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    cart = Cart.find(params[:id])
    cart.destroy
    redirect_back(fallback_location: root_path)
  end
end
