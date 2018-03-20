class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, except: [:index, :show]
  # GET /productcategories
  # GET /productcategories.json
  def index
    @categories = Category.all
  end

  # GET /productcategories/1
  # GET /productcategories/1.json
  def show
      @category = Category.find(params[:id])
      @products = @category.products
  end

  # GET /productcategories/new
  def new
    @category = Category.new
  end

  # GET /productcategories/1/edit
  def edit
  end

  # POST /productcategories
  # POST /productcategories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Productcategory was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /productcategories/1
  # PATCH/PUT /productcategories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Productcategory was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /productcategories/1
  # DELETE /productcategories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end
