class RemoveThumbImageFromPortfolio < ActiveRecord::Migration[6.0]
  def change
    remove_column :portfolios, :thumb_image, :string
  end
end
