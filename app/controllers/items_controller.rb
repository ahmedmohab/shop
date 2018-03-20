class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
#  def index
#    @items = Item.all
#  end

  # GET /items/new
  def new
    @item = Item.new
  end
    
    
    def add_item
        @user_id = 
        if current_user
            current_user
        else
            cookies.signed[:user_id]
        end
        @cart = Cart.where('user_id = ?', @user_id).first
        if !@cart
            @cart = Cart.new(params[:user_id])
            @cart.save
        end
       if @product = Product.find(params[:product_id])
            @item = Item.where('product_id = ? AND cart_id = ?', params[:product_id], @cart.id).first
            if  @item != nil
                @item.update(icount: @item.icount + 1)
            else
                @item = Item.create(product_id: params[:product_id], cart_id: @cart.id)
            end
        @item.save
        end
        #Rails.logger.info(@item.errors.inspect) 

#        format.html { redirect_to @cart, notice: @item.errors.full_messages }
        
#        product.errors.full_messages
        redirect_to products_url
    end
  # GET /items/1/edit
  def edit
  end
    
  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save!
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
#  def destroy
#    @item.destroy
#    respond_to do |format|
#      format.html { redirect_to carts_url, notice: 'Item was successfully destroyed.' }
#      format.json { head :no_content }
#    end
#  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.permit(:cart_id, :product_id, :icount, :order_id)
    end
end
