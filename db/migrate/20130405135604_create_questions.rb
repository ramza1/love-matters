class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.string :email
      t.string :website
      t.text :question
      t.text :answer
      t.belongs_to :user

      t.timestamps
    end
    add_index :questions, :user_id
  end
end
