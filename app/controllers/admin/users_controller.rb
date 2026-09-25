class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = Current.account.users.where(role: %i[agent admin]).search(params[:q]).order(:email_address)
  end

  def new
    @user = Current.account.users.new
  end

  def create
    @user = Current.account.users.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "User created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(update_user_params)
      redirect_to admin_users_path, notice: "User updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!

    redirect_to admin_users_path, notice: "User deleted successfully"
  end

  private

  def set_user
    @user = Current.account.users.where(role: %i[agent admin]).find(params[:id])
  end

  def user_params
    params.expect(user: [
      :email_address,
      :password,
      :password_confirmation,
      :role
    ])
  end

  def update_user_params
    permitted = params.expect(user: [
      :email_address,
      :role
    ])

    permitted
  end
end
