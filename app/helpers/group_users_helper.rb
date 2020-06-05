module GroupUsersHelper
  # userが承認していないgroup_usersを返す
  def unpermit_group_users(user)
    @unpermit_group_users = user.group_users.where(permission: false)
  end

  # group_userレコードのpermission:true or false を判定するメソッド
  def permitted_group_user?(user, group)
    # userが所属するgroupの中から、groupのidと同じレコードのみをgroup_usersとして取得
    group_user = user.group_users.find_by(group_id: group.id)
    # そのレコードのpermissionの値を返す(true or false)
    group_user.permission
  end
end