class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month, :update_one_month]
  before_action :logged_in_user, only: [:update, :edit_one_month]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]
  before_action :set_one_month, only: [:edit_one_month]
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"
  
  
  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0),
        beta_started_at: Time.current.change(sec: 0)
        )
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0),
        beta_finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  def edit_one_month
  end
  
  def update_one_month
    ActiveRecord::Base.transaction do # トランザクションを開始します。
      attendances_params.each do |id, item|
        if params[:user][:attendances][id][:onemonth_id] != nil
          attendance = Attendance.find(id)
          attendance.update_attributes!(item)
        end
      end
    end
    flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
    redirect_to user_url(date: params[:date])
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐
    flash[:danger] = "無効な入力データがあったため、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end
  
  
  def edit_overtime
    @user = User.find(params[:user_id])
    @superior_users = User.where(superior: true)
    @attendance = Attendance.find(params[:id])
  end
  
  def update_overtime
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    if @attendance.update_attributes(overtimes_params)
      flash[:success] = "残業申請しました。"
    else
      flash[:danger] = "無効なデータがありました。"
    end
      redirect_to @user
  end
  
  def index_over_time
    @user = User.find(params[:id])
    @attendances = Attendance.where(over_id: @user.id)
    @attendances.each do |attendance|
      @users = User.includes(:attendances).where(attendances: {over_id: @user.id})
    end
  end

  def over_update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    app_params.each do |id, item|
      @attendance = Attendance.find(id)
      if params[:user][:attendances][id][:over_change] == "1"
        if @attendance.update_attributes!(item) 
          flash[:success] = "変更を送信しました"
        else
          flash[:danger] = "変更を送信できませんでした"
        end
      end
    end
    redirect_to @user
  end
  
  def index_one_month
    @user = User.find(params[:id])
    @attendances = Attendance.where(onemonth_id: @user.id)
    @attendances.each do |attendance|
      @users = User.includes(:attendances).where(attendances: {onemonth_id: @user.id})
    end
  end
  
  def one_month_approval_update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    one_params.each do |id, item|
      @attendance = Attendance.find(id)
      if params[:user][:attendances][id][:one_month_change] == "1"
        if @attendance.update_attributes!(item) 
          flash[:success] = "変更を送信しました"
        else
          flash[:danger] = "変更を送信できませんでした"
        end
      end
    end
    redirect_to @user
  end
  
  def index_approval_log
    @user = User.find(params[:id])
    @attendances = Attendance.where(onemonth_confirm: 2)
    @attendances.each do |attendance|
      @users = User.includes(:attendances).where(attendances: {user_id: @user.id, onemonth_confirm: 2})
      @superior_users = User.includes(:attendances).superior_users
    end

  end
  
  
  private
  
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note, :onemonth_id, :beta_started_at, :beta_finished_at, :beta_note, :onemonth_confirm, :one_next_day])[:attendances]
    end
    
    def overtimes_params
      params.require(:attendance).permit(:scheduled_end_time, :occupation, :over_id, :over_confirm, :over_next_day)
    end
    
    def app_params
      params.require(:user).permit(attendances: [:over_confirm])[:attendances]
    end
    
    def one_month_params
      params.require(:attendance).permit(:onemonth_id)
    end
    
    def one_params
      params.require(:user).permit(attendances: [:onemonth_confirm])[:attendances]
    end
    
    def beta_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note])[:attendances]
    end
  

    
    
end