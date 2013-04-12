class UsersController < BaseController

  before_filter :authenticate_user!

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  def show
     @user = User.find(params[:id])
  end

  def new
     @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_path(@user), notice: "User Created"
    else
      render action: 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to user_path(@user), notice: "User Updated"
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "User Deleted"
  end
end
