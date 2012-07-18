class CreateExcos < ActiveRecord::Migration
  def change
    create_table :excos do |t|

      t.string :name
      t.text :description
      t.integer :enrollment_limit

      t.integer :year
      t.string :term

      t.timestamps

    end
  end
end
