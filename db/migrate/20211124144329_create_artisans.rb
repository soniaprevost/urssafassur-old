class CreateArtisans < ActiveRecord::Migration[6.1]
  def change
    create_table :artisans do |t|
      t.string :siret
      t.string :secteur

      t.timestamps
    end
  end
end
