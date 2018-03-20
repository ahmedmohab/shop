class OrdersController < ApplicationController
  before_action :set_order, only: [:show]

  # GET /orders
  # GET /orders.json
  def index
      if current_user 
           @user_id =  current_user.id
        else
            @user_id = cookies.signed[:user_id]
        end 
    @orders = Order.where('user_id = ?', @user_id)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
      if current_user 
           @user_id =  current_user.id
        else
            @user_id = cookies.signed[:user_id]
        end 
    respond_to do |format|
      if @order.update(order_params)
          @order.user_id = @user_id
          @cart = Cart.find_by(user_id: @user_id)
            @items = Item.where('cart_id = ?', @cart.id)
            @items.each do |item|
                item.order_id = @order.id
                item.cart_id = nil
                item.save
            end
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
#  def destroy
#    @order.destroy
#    respond_to do |format|
#      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
#      format.json { head :no_content }
#    end
#  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
     def order_params
      params.require(:order).permit(:user_id, :orderamount, :ordershipaddress, :ordercity, :guest_phone, :guest_email, :guest_email, :order_date, :shipped, :tracking_number)
    end
end
