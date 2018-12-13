class AddFavoriteToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :fav, :boolean
  end
end
