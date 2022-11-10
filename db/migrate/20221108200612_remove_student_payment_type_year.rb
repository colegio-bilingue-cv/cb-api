class RemoveStudentPaymentTypeYear < ActiveRecord::Migration[7.0]
  def change
    remove_column :student_payment_methods, :year
  end
end
