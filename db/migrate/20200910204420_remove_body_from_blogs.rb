class RemoveBodyFromBlogs < ActiveRecord::Migration[6.0]
  def change
    remove_column :blogs, :body, :string
  end
end
