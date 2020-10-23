# frozen_string_literal: true

class GradeUnitService < ApplicationService
  @@hash_days = {
    "monday" => 0,
    "tuesday" => 1,
    "wednesday" => 2,
    "thursday" => 3,
    "friday" => 4,
    "saturday" => 5,
    "sunday" => 6
  }

  def initialize(unit_id, grade_id, group_id, days_of_week,
                 starts_on_year, starts_on_month, starts_on_day, starts_on_hour, starts_on_minute,
                 ends_on_year, ends_on_month, ends_on_day, ends_on_hour, ends_on_minute)
    @unit = Unit.find unit_id
    @grade = Grade.find grade_id
    @group = Group.find group_id
    @days_of_week = days_of_week
    @starts_on = DateTime.new(starts_on_year.to_i, starts_on_month.to_i, starts_on_day.to_i, starts_on_hour.to_i, starts_on_minute.to_i)
    @ends_on = DateTime.new(ends_on_year.to_i, ends_on_month.to_i, ends_on_day.to_i, ends_on_hour.to_i, ends_on_minute.to_i)
  end

  def call
    self
  end

  def create
    @grade.grade_units.create(unit: @unit, group: @group, starts_on: @starts_on, ends_on: @ends_on)
  end

  def create_weekly
    while @starts_on < @grade.end_date
      @days_of_week.each do |day_name|
        @grade.grade_units.create(unit: @unit,
                                  group: @group,
                                  starts_on: @starts_on.beginning_of_week + @@hash_days[day_name].days + @starts_on.hour.hours + @starts_on.minute.minutes,
                                  ends_on: @ends_on.beginning_of_week + @@hash_days[day_name].days + @ends_on.hour.hours + @ends_on.minute.minutes)
      end
      @starts_on = @starts_on + 1.week
      @ends_on = @ends_on + 1.week
    end
  end

  def create_biweekly
    while @starts_on < @grade.end_date
      @days_of_week.each do |day_name|
        @grade.grade_units.create(unit: @unit,
                                  group: @group,
                                  starts_on: @starts_on.beginning_of_week + @@hash_days[day_name].days + @starts_on.hour.hours + @starts_on.minute.minutes,
                                  ends_on: @ends_on.beginning_of_week + @@hash_days[day_name].days + @ends_on.hour.hours + @ends_on.minute.minutes)
      end
      @starts_on = @starts_on + 2.week
      @ends_on = @ends_on + 2.week
    end
  end
end
