class DropArticlesCategories < ActiveRecord::Migration[5.0]
  def change
    drop_table :articles_categories
  end
end
