class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.references :site
      t.string :domain
      t.boolean :is_primary, :default=>false

      t.timestamps
    end
    add_index :domains, :site_id
  end
end
