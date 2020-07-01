class GroupsController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update, :search_user]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    # トランザクションを適用(グループの作成と中間テーブルの同時作成)
    @group.transaction do
      @group.save!
      current_user.group_users.create!(group_id: @group.id, permission: true)
    end
    # 成功時の処理
      flash[:success] = '新しいグループを作成しました'
      redirect_to @group
    rescue => e
    # 失敗時の処理
      flash.now[:danger] = 'グループ作成に失敗しました'
      render :new
  end

  def show
    @users = @group.users.order(id: :asc)
    @q = @group.thanks.ransack(params[:q]) # search_form_for用
    @thanks = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(15)
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:success] = 'グループ名を変更しました'
      redirect_to @group
    else
      flash.now[:danger] = 'グループ名変更に失敗しました'
      render :edit
    end
  end

  def search_user
    @group_user = GroupUser.new # form_with用
    @q = User.where.not(id: current_user.id).ransack(params[:q]) # search_form_for用

    if params[:q] != nil && params[:q][:name_cont].presence # 検索をした場合且つ、空文字での検索ではない場合のみuserインスタンスを取得する
      users = @q.result(distinct: true).order(id: :desc)
      @invitable_users = users.reject { |user| user.groups.include?(@group) } # 招待可能ユーザに限定した配列にする
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  # グループ参加済みユーザのみに操作を限定
  def correct_user
    @group = Group.find_by(id: params[:id])
    unless permitted_group_user(current_user, @group)
      flash[:danger] = 'エラー'
      redirect_to root_url
    end
  end
end
