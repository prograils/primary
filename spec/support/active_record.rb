ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migrator.up "db/migrate"

load Rails.root.join('db/schema.rb')
