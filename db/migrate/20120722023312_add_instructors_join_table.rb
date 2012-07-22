class AddInstructorsJoinTable < ActiveRecord::Migration
  def change
    create_table :excos_instructors, :id => false do |t|
      t.integer :exco_id
      t.integer :user_id
    end
  end
end
