class CreateJoinTableFamilyMemberStudent < ActiveRecord::Migration[7.0]
  def change
    create_join_table :family_members, :students do |t|
       #t.index [:family_member_id, :student_id]
       #t.index [:student_id, :family_member_id]
    end
  end
end
