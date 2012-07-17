class CreateExcos < ActiveRecord::Migration
  def change
    create_table :excos do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
