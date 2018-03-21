class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :edit, :destroy]
    before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy, :all]
    
     
    def index
        if !current_user
            if cookies.signed[:user_id] == nil
                cookies.permanent.signed[:user_id] = rand(10 ** 8)
            end
            @user_id = cookies.signed[:user_id]
        else
            @user_id = current_user.id
        end
        
        @cart = Cart.find_by(user_id: @user_id)
        if !@cart
            @cart = Cart.new(user_id: @user_id)
            @cart.save
        end
        
        @products = Product.all
        @categories = Category.all
    end
    
    
    def all
        @products = Product.all
    end
    
    
    def show
        @category = Category.find(@product.category_id)
    end
    
    
    def new
        @product = Product.new
    end
    
    
    def edit
    end
    
    
    def create
        @product = Product.new(product_params)
        respond_to do |format|
            if @product.save
                format.html { redirect_to @product, notice: 'Product was successfully created.' }
                format.json { render :show, status: :created, location: @product }
            else
                format.html { render :new }
                format.json { render json: @product.errors, status: :unprocessable_entity }
            end
        end
    end
    
    
    def update
        respond_to do |format|
            if @product.update(product_params)
                format.html { redirect_to @product, notice: 'Product was successfully updated.' }
                format.json { render :show, status: :ok, location: @product }
            else
                format.html { render :edit }
                format.json { render json: @product.errors, status: :unprocessable_entity }
            end
        end
    end
    
    
    def destroy
        @product.destroy
        respond_to do |format|
            format.html { redirect_to all_products_path, notice: 'Product was successfully destroyed.' }
            format.json { head :no_content }
        end
    end
    
    
    private
    
    
    def set_product
      @product = Product.find(params[:id])
    end


    def product_params
      params.require(:product).permit(:name, :price, :weight, :desc, :thumb, :image, :category_id, :stock)
    end
  end
