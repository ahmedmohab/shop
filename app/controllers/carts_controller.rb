class CartsController < ApplicationController
    before_action :set_user, only: [:index, :checkout, :confirm]
    
    
    def index
        @cart = Cart.find_by(user_id: @user_id)
        if @cart == nil
            @cart = Cart.new(user_id: @user_id)
            @cart.save
        end
    end
    
    
    def checkout
        @cart = Cart.find_by(user_id: @user_id)
        @items = Item.where('cart_id = ?', @cart.id)
    end
    
    
    def confirm
        @cart = Cart.find_by(user_id: @user_id)
        @items = Item.where('cart_id = ?', @cart.id)
        @subtotal = 0
        @items.each do |item|
            @product = Product.find_by(id: item.product_id)
            @subtotal += @product.price * item.icount
        end
        @order = Order.new
        @order.user_id = @user_id
        @order.orderamount = @subtotal
        @order.save
        if current_user
            @order.user_id = @user_id
            @items = Item.where('cart_id = ?', @cart.id)
            @items.each do |item|
                item.order_id = @order.id
                item.cart_id = nil
                item.save
            end
            redirect_to '/orders/'
        else
            redirect_to '/order/'+@order.id.to_s + '/edit/'
        end
    end
    
    
  def new
      if !Cart.where('user_id = ?', user_id).first
          @cart = Cart.new(cart_params)
      end
  end
    
    
    
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end
    
    
  private

    
    def set_user
        if current_user 
           @user_id =  current_user.id
        else
            @user_id = cookies.signed[:user_id]
        end 
    end
    
      
    def cart_params
      params.require(:user_id)
    end
end
