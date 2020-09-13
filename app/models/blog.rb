class Blog < ApplicationRecord
	enum status: {draft: 0, published: 1}
	extend FriendlyId
  	friendly_id :title, use: :slugged

		has_rich_text :body

		has_many :comments, as: :commentable, dependent: :destroy

		validates_presence_of :title, :body

	#	belongs_to :topic
end
