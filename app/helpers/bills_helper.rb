# frozen_string_literal: true

module BillsHelper
  def bill_color(bill)
    return bill.color unless bill.nil?
    '#000000'
  end

  def build_website_link(bill_url)
    link_to('Website', bill_url) unless bill_url.nil?
  end
end
