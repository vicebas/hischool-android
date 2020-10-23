# frozen_string_literal: true

class GradeUnitDecorator < Draper::Decorator
  delegate_all

  def starts_on_date
    I18n.localize object.starts_on, format: :date_default
  end

  def starts_on
    I18n.localize object.starts_on, format: :time_default
  end

  def ends_on
    I18n.localize object.ends_on, format: :time_default
  end

  def registered_at_time
    I18n.localize object.teacher_clock_in, format: :time_default
  end
end
