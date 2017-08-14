class AddLanguageToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :language, :text
  end
end
