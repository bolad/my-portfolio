class Portfolio < ApplicationRecord
  acts_as_list
  include Placeholder

  validates_presence_of :title, :body, :main_image, :thumb_image
  has_many :technologies
  accepts_nested_attributes_for :technologies,
                                reject_if: lambda {|attr| attr['name'].blank?}

  def self.javascript
    where(subtitle: 'Javascript')
  end

  scope :react_portfolio, -> { where(subtitle: 'React With Rails') }

  after_initialize :set_defaults

  def set_defaults
    self.main_image ||= Placeholder.image_generator(height: '600', width: '400')
    self.thumb_image ||= Placeholder.image_generator(height: '350', width: '200')
  end

  def self.by_position
    order("position ASC")
  end
end
