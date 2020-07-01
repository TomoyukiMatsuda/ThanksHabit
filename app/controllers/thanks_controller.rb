class ThanksController < ApplicationController
  before_action :correct_user, only: :destroy

  def create
    @thank = current_user.thanks.build(thank_params)

    if @thank.save
      flash[:success] = "#{@thank.receiver.name} さんに感謝しました"
      redirect_to root_url
    else
      flash.now[:danger] = '感謝の登録に失敗しました'
      @groups = current_user.groups.order(id: :desc).page(params[:page]).per(5)
      @thanks = current_user.thanks.where.not(created_at: nil)
      render 'toppages/index'
    end
  end

  def destroy
    if @thank.destroy
      flash[:warning] = '状態を元に戻しました'
      redirect_to root_url
    else
      flash[:danger] = '状態を元に戻せませんでした'
      @groups = current_user.groups.order(id: :desc).page(params[:page]).per(5)
      @thanks = current_user.thanks.where.not(created_at: nil)
      render 'toppages/index'
    end
  end

  private

  def thank_params
    params.require(:thank).permit(:content, :receiver_id, :group_id)
  end

  def correct_user
    @thank = current_user.thanks.find_by(id: params[:id])
    unless @thank
      flash[:danger] = 'エラー'
      redirect_to root_url
    end
  end
end
