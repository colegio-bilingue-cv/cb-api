class AddIdToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :id, :primary_key
  end
end
