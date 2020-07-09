class AddDefaultValueToTutorials < ActiveRecord::Migration[5.2]
  def change
    remove_column :tutorials, :description
    add_column :tutorials, :description, :string, default: "No description"
  end
end
