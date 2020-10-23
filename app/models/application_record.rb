# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def first_error_message
    errors.messages.map { |attr, value| { "error" => value[0] } }.first
  end
end
