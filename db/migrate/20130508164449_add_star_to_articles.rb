class AddStarToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :starred, :boolean
  end
end
