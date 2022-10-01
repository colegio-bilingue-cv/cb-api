class CreateJoinTableStudentPaymentMethod < ActiveRecord::Migration[7.0]
  def change
    create_join_table :payment_methods, :students, table_name: :student_payment_methods do |t|
      t.date :year
   end
  end
end
