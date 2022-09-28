class AddReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :cicle, foreing_key: true
  end
end
