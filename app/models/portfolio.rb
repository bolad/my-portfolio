class Portfolio < ApplicationRecord
  acts_as_list
  has_one_attached :photo, dependent: :destroy
  validates :photo, content_type: [:png, :jpg, :jpeg]

  validates_presence_of :title, :body
  has_many :technologies
  accepts_nested_attributes_for :technologies,
                                reject_if: lambda {|attr| attr['name'].blank?}

  def self.by_position
    order("position ASC")
  end
end
