module GroupUsersHelper
  # userが承認していないgroup_usersを取得
  def unpermit_group_users(user)
    @unpermit_group_users = user.group_users.where(permission: false)
  end

  # group_userインスタンスのpermission:true or false を判定
  def permitted_group_user?(user, group)
    group_user = user.group_users.find_by(group_id: group.id)
    group_user.permission # permissionの値を返す(true or false)
  end
end