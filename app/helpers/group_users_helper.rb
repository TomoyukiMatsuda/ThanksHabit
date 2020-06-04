module GroupUsersHelper
  # 招待済み、且つ承認していないgroup_usersレコードを取得
  def invited_groups
    @invited_groups = current_user.group_users.where(permission: false)
  end
end
