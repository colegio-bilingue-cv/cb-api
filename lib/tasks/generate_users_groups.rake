desc "Generate user's and group's instances"
task generate_users_groups: :environment do
  # USERS
  user_administrator = User.create!(name: 'Luis', surname: 'Alberto', email: 'administrator@test.com', password: 'password', ci: '1234567A')
  user_administrator.add_role('administrator')

  user_principal = User.create!(name: 'Carlos', surname: 'Lopez', email: 'principal@test.com', password: 'password', ci: '1234567F')
  user_principal.add_role('principal')

  user_teacher = User.create!(name: 'Rosa', surname: 'Rodriguez', email: 'teacher@test.com', password: 'password', ci: '1234567B')
  user_teacher.add_role('teacher')

  user_support_teacher = User.create!(name: 'Marta', surname: 'Sanchez', email: 'support_teahcer@test.com', password: 'password', ci: '1234567C')
  user_teacher.add_role('support_teacher')

  user_administrative = User.create!(name: 'Juan', surname: 'Perez', email: 'administrative@test.com', password: 'password', ci: '1234567D')
  user_administrative.add_role('administrative')

  user_reception= User.create!(name: 'Ana Maria', surname: 'Suarez', email: 'reception@test.com', password: 'password', ci: '1234567E')
  user_reception.add_role('reception')

  #GROUPS
  group_a = Group.create!(grade_id: 1, name: 'A', year: 2022)
  group_b = Group.create!(grade_id: 1, name: 'B', year: 2023)

  UserGroup.create!(user_id: user_teacher.id, group_id: group_a.id, role_id: 1)
  UserGroup.create!(user_id: user_support_teacher.id, group_id: group_a.id, role_id: 2)
  UserGroup.create!(user_id: user_principal.id, group_id: group_a.id, role_id: 3)
  UserGroup.create!(user_id: user_principal.id, group_id: group_bss.id, role_id: 3)

  #STUDENTS

end
