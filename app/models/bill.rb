# frozen_string_literal: true

class Bill < ActiveRecord::Base
  KINDS = %w[income expense].freeze

  belongs_to :bank

  has_many :recurrences, dependent: :destroy
  has_many :exclusions, dependent: :destroy

  accepts_nested_attributes_for :recurrences

  before_validation :normalize_bill_type, :color_check

  validates_presence_of :summary, :color
  validates :bill_type, inclusion: { in: Bill::KINDS,
                                     message: "%{value} must be one of the following: #{Bill::KINDS.join(', ')}" }

  # Defines income? expense?
  Bill::KINDS.each do |kind|
    define_method("#{kind}?") do
      kind == bill_type
    end
  end

  def next_due
    recurrences.first unless recurrences.blank?
  end

  private

  def normalize_bill_type
    self.bill_type = bill_type.downcase.strip if bill_type
  end

  def color_check
    self.color = "##{"%06x" % (rand * 0xffffff)}" unless color
  end
end
