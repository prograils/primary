class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.boolean :is_default, :default=>false

      t.timestamps
    end
  end
end
