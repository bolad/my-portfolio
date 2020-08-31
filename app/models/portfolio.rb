class Portfolio < ApplicationRecord
  acts_as_list
  include Placeholder
  has_one_attached :photo, dependent: :destroy
  validates :photo, content_type: [:png, :jpg, :jpeg]

  validates_presence_of :title, :body
  has_many :technologies
  accepts_nested_attributes_for :technologies,
                                reject_if: lambda {|attr| attr['name'].blank?}

  def self.javascript
    where(subtitle: 'Javascript')
  end

  # def main_image
  #   return self.photo.variant(resize: '650x400!').processed
  # end
  #
  # def thumb_image
  #   return self.photo.variant(resize: '350x200!').processed
  # end
  #
  # scope :react_portfolio, -> { where(subtitle: 'React With Rails') }

  after_initialize :set_defaults

  def set_defaults
    #self.photo ||= Placeholder.image_generator(height: '600', width: '400')
    self.photo ||= Placeholder.image_generator(height: '350', width: '200')
  end

  def self.by_position
    order("position ASC")
  end
end
