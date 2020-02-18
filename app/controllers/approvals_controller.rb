class ApprovalsController < ApplicationController
  protect_from_forgery
  
  def index

  end
  
  def new
    @approval = Approval.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @approval = @user.approvals.create(approvals_params)
    @superior_user = User.where(superior: true)
      if @approval.save
        flash[:success] = "申請しました！"
        redirect_to user_path(@user)
      else
        
        
      end
  end

  
  private
    def approvals_params
      params.require(:approval).permit(:superior_id)
    end
end
