class CartsController < ApplicationController
before_action :set_cart, only: [:update]
@user_id
    @cart
    @items
  # GET /carts
  # GET /carts.json
  def index
      if current_user 
           @user_id =  current_user.id
        else
            @user_id = cookies.signed[:user_id]
        end 
     @cart = Cart.find_by(user_id: @user_id)
      if @cart == nil
          @cart = Cart.new(user_id: @user_id)
          @cart.save
      end
#      @items = Item.where('cart_id = ?', @cart.id)
  end
    
#    def add_item
#        @cart = Cart.new(params)
#        @cart.save
#    end
    
  # GET /carts/new\
def checkout
    if current_user 
           @user_id =  current_user.id
        else
            @user_id = cookies.signed[:user_id]
        end 
     @cart = Cart.find_by(user_id: @user_id)
    @items = Item.where('cart_id = ?', @cart.id)
end
    
    
    def confirm
        if current_user 
           @user_id =  current_user.id
        else
            @user_id = cookies.signed[:user_id]
        end 
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
        else
            
            redirect_to '/order/'+@order.id.to_s + '/edit/'
        end
    end
    
    
  def new
      if !Cart.where('user_id = ?', user_id).first
          @cart = Cart.new(cart_params)
      end
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
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
#
#  # PATCH/PUT /carts/1
#  # PATCH/PUT /carts/1.json
#  def update
#    respond_to do |format|
#      if @cart.update(cart_params)
#        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
#        format.json { render :show, status: :ok, location: @cart }
#      else
#        format.html { render :edit }
#        format.json { render json: @cart.errors, status: :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /carts/1
#  # DELETE /carts/1.json
#  def destroy
#    @cart.destroy
#    respond_to do |format|
#      format.html { redirect_to carts_url, notice: 'Item was successfully Deleteed.' }
#      format.json { head :no_content }
#    end
#  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

        
       
        
        
    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:user_id)
    end
end
