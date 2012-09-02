class AddCreditsToExcos < ActiveRecord::Migration
  def change
    add_column :excos, :credits, :integer
  end
end
