class ApprovalsController < ApplicationController
  protect_from_forgery

  
  def index
    @user = User.find(params[:user_id])
    @approvals = Approval.all
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
      params.require(:approval).permit(:superior_id)
    end
end
