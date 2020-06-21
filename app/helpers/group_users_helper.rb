module GroupUsersHelper

  # userが承認していないgroup_usersを取得する
  def unpermit_group_users(user)
    @unpermit_group_users = user.group_users.where(permission: false)
  end

  # ユーザが参加済みのグループかどうか確認する。取得できればインスタンスを、なければnilを返す。
  def permitted_group_user(user, group)
    user.group_users.where(permission: true).find_by(group_id: group.id)
  end
end