# frozen_string_literal: true

class TeacherSpreadsheetService < ApplicationService
  def initialize(file, institution_id)
    @file = file
    @institution = Institution.find(institution_id)
  end

  def call
    if @file.content_type == "text/csv"
      status = generate_teachers_csv
    else
      generate_teachers_xlsx
    end
    true
  end

  def generate_teachers_csv
    spreadsheet = Roo::Spreadsheet.open(@file, extension: :csv)
    spreadsheet.each_with_index(email: "e-mail", nome: "nome", cpf: "cpf") do |hash, index|
      next if index.zero?
      TeacherService.call(
        user_attributes: {
          email: hash[:email],
        },
        name: hash[:nome],
        tax_id: hash[:cpf].to_i.to_s.rjust(11, "0"),
        institution_id: @institution.id
      )
    end
  end

  def generate_teachers_xlsx
    spreadsheet = Roo::Spreadsheet.open(@file, extension: :xlsx)
    spreadsheet.each_row_streaming(offset: 1) do |row|
      TeacherService.call(
        user_attributes: {
          email: row[0].value,
        },
        name: row[1],
        tax_id: row[2].value.to_i.to_s.rjust(11, "0"),
        institution_id: @institution.id
      )
    end
  end
end
