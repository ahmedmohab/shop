class UsersController < ApplicationController
#  before_action :set_user, only: [:edit, :update, :destroy]
 before_action :authorize_admin, only: [:index, :makeadmin, :admin]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
    
    def login
        sign_in(User.find(params[:id]),scope: :user)
    end
    
  # GET /users/1
  # GET /users/1.json
  def show
      @user = User.find(params[:id])
  end

    
    def admin
    end
    
  # GET /users/new
  def new
    @user = User.new
     # @cart = Cart.new(@user.id)
  end

  # GET /users/1/edit
  def edit
      @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(account_update)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
    
    def makeadmin
        @user = User.find(params[:id])
        @user.update_attribute :admin, true
        redirect_to '/users/'
    end
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        list_params_allowed = [:email, :password, :userfirstname, :userlastname, :usercity, :userphone, :useraddress]
  # Add the params only for admin
  list_params_allowed << :admin if current_user.try(:admin?)
        arams.require(:user).permit(list_params_allowed)
    end
end
