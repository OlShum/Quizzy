class AddScoreToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :score, :integer
  end
end
