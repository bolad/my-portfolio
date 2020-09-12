class AddViewsToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_column :blogs, :views, :integer, default: 0
  end
end
