class AddSearchVectorToArticles < ActiveRecord::Migration[7.1]
  def up
    add_column :articles, :search_vector, :tsvector
    add_index :articles, :search_vector, using: 'gin'
    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON articles FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(search_vector, 'pg_catalog.english', title);
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON articles;
    SQL
    remove_index :articles, :search_vector
    remove_column :articles, :search_vector
  end
end


