class ApprovalsController < ApplicationController
  protect_from_forgery

  before_action :superior_user, only: [:index_approvals, :update]

  def update
    @user = User.find(params[:user_id])
    approval_params.each do |id, item|
      @approval = Approval.find(id)
      if params[:user][:approvals][id][:approval_change] == "1"
        if @approval.update_attributes!(item) 
          flash[:success] = "変更を送信しました"
        else
          flash[:danger] = "変更を送信できませんでした"
        end
      end
    end
    redirect_to @user
  end
  
  def index_approvals
    @user = User.find(params[:id])
    @approvals = Approval.all
    @approvals.each do |approval|
      @users = User.includes(:approvals).where(approvals: {superior_id: @user.id, superior_comfirm: 1})
    end
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day] # 対象の月の日数を代入します。
  end
  
  def create
    @user = User.find(params[:user_id])
    @approvals = @user.approvals.where(id: @user.id)
    @approval = @user.approvals.create(approvals_params)
    @superior_user = User.superior_users
        if @approval.save
          flash[:success] = "申請しました！"
        else
          flash[:danger] = "申請する上長を選択してください"
        end
    redirect_to user_path(@user)
  end
  
  def approval_update
    @user = User.find(params[:user_id])
    @approval = @user.approvals.find_by(user_id: @user.id, month: params[:date])
    if @approval.update_attributes(app_params)
      flash[:success] = "申請しました！"
    else
      flash[:danger] = "申請する上長を選択してください"
    end
    redirect_to user_path(@user)
  end 

  private
  
    def approvals_params
      params.require(:approval).permit(:superior_id, :superior_comfirm, :approval_change, :month)
    end
    
    def approval_params
      params.require(:user).permit(approvals: [:superior_id, :superior_comfirm, :month])[:approvals]
    end
    
    def app_params
      params.require(:approval).permit(:superior_id, :superior_comfirm)
    end
end
