class AddNameAndApeToArtisans < ActiveRecord::Migration[6.1]
  def change
    add_column :artisans, :name, :string
    add_column :artisans, :ape_code, :string
  end
end
