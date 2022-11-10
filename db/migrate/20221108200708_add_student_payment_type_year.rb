class AddStudentPaymentTypeYear < ActiveRecord::Migration[7.0]
  def change
    add_column :student_payment_methods, :year, :integer
  end
end
