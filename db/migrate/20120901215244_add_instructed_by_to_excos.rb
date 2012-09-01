class AddInstructedByToExcos < ActiveRecord::Migration
  def change
    add_column :excos, :instructed_by, :string
  end
end
