class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info, :index]
  before_action :set_one_month, only: :show
  before_action :update_employee, only: :update_basic_info
  before_action :update, only: :update_basic_info
  
  
  
  
  def index
    @users = User.paginate(page: params[:page]).search(params[:search])
  end
  
  def show
    @approval = Approval.new
    @superior_users = User.where(superior: true)
    @worked_sum = @attendances.where.not(started_at: nil).count
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  def edit_basic_info
  end
  
  def update_basic_info
    if @user.update_attributes(basic_info_params)
        flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  def update_employee
    if @user.update_attributes(employee_params)
      flash[:success] ="#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
  end
  
  def search
    @users = User.search(params[:search])
  end
  
  def self.search(search)
    return User.all unless search
    User.where(['content LIKE ?', "%#{search}%"])
  end
  
  def start_employee
    Attendance.where.not(started_at: nil).each do |attendance|
      if (Date.current == attendance.worked_on) && attendance.finished_at.nil?
        @users = User.all.includes(:attendances)
      end
    end
  end

  private
  
      def user_params
        params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
      end
      
      def basic_info_params
        params.require(:user).permit(:department, :basic_time, :work_time)
      end      
      
      def employee_params
        params.require(:user).permit(:employee_number, :uid)
      end
end

