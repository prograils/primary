class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.string :url
      t.boolean :is_primary

      t.timestamps
    end
  end
end
