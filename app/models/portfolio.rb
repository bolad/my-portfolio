class Portfolio < ApplicationRecord
  include Placeholder
  
  validates_presence_of :title, :body, :main_image, :thumb_image
  has_many :technologies

  def self.javascript
    where(subtitle: 'Javascript')
  end

  scope :react_portfolio, -> { where(subtitle: 'React With Rails') }

  after_initialize :set_defaults

  def set_defaults
    self.main_image ||= Placeholder.image_generator(height: '600', width: '400')
    self.thumb_image ||= Placeholder.image_generator(height: '350', width: '200')
  end
end
