class ChangeColumnTypeForReferenceNumber < ActiveRecord::Migration[7.0]
  def change
    change_table :students do |t|
      t.change :reference_number, :string
    end
  end
end
