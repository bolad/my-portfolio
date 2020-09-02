class RemoveMainImageFromPortfolio < ActiveRecord::Migration[6.0]
  def change
    remove_column :portfolios, :main_image, :string
  end
end
