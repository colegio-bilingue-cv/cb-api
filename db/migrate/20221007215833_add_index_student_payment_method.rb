class AddIndexStudentPaymentMethod < ActiveRecord::Migration[7.0]
  def change
    add_index :student_payment_methods, [:student_id, :payment_method_id, :year], unique: true, name: 'index_student_payment_method_year'
  end
end
