class ChangeColorToBeDefaultValueInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :color, :string, default: "#005a55"
  end
end
