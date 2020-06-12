module GroupUsersHelper
  # userが承認していないgroup_usersを取得
  def unpermit_group_users(user)
    @unpermit_group_users = user.group_users.where(permission: false)
  end

  # ユーザが参加済みのグループかどうか確認、返り値はtrue/false/nilの3通り
  def permitted_group_user(user, group)
    group_user = user.group_users.find_by(group_id: group.id)
    group_user.permission unless group_user == nil
  end
end