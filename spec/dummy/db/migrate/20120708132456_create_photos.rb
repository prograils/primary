class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_file_name
      t.string :photoable_type
      t.integer :photoable_id
      t.boolean :is_primary, :default=>false

      t.timestamps
    end
    add_index :photos, [:photoable_id, :photoable_type]
  end
end
