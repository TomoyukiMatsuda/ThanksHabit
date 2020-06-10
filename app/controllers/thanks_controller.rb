class ThanksController < ApplicationController

  def create
    # @thankにはデータあり
    @thank = current_user.thanks.build(thank_params)
    if @thank.tell_thank(current_user, thank_params[:receiver_id], thank_params[:group_id])
      flash[:success] = '感謝を登録しました'
      redirect_to root_url
    else
      flash.now[:danger] = '感謝の登録に失敗しました'
      @groups = current_user.groups.order(id: :desc).page(params[:page]).per(5)
      @thanks = current_user.thanks.where.not(created_at: nil)
      render 'toppages/index'
    end
  end

  def destroy
    thank = Thank.find_by(id: params[:id])
    thank.undo
    flash[:warning] = '習慣の状態を元に戻しました'
    redirect_back(fallback_location: root_url)
  end

  private

  def thank_params
    params.require(:thank).permit(:content, :receiver_id, :group_id)
  end
end
