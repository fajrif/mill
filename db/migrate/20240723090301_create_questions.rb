class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :question, null: false, default: ""
      t.string :answer, null: false, default: ""
      t.string :category_name, null: false, default: ""
    end
  end
end
