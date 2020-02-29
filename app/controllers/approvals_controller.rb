class ApprovalsController < ApplicationController
  protect_from_forgery

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
  
  def index
    @user = User.find(params[:user_id])
    @approvals = Approval.all
    @approvals.each do |approval|
        @users = User.all.includes(:approvals).where(approvals: {superior_id: @user.id})
    end
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day] # 対象の月の日数を代入します。
  end
  
  def create
    @user = User.find(params[:user_id])
    @approval = @user.approvals.create(approvals_params)
    @superior_user = User.superior_users
        if @approval.save
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
end
