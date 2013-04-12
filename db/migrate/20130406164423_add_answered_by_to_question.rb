class AddAnsweredByToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :answered_by, :integer
  end
end
