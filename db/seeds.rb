# frozen_string_literal: true

admin = Admin.create(email: "admin@admin.com", password: "qweqwe", name: "Admin")
institution = admin.build_institution(name: "Santo Agostinho")
institution.save
branches = institution.branches.create([
    {
      name: "Belo Horizonte",
      code: "UNI31234",
      cep: "30130135",
      street: "Rua Rio Grande do Norte",
      address_number: "1325",
      neighborhood: "Funcionários",
      complement: "de 671/672 a 1229/1230",
      city: "Belo Horizonte",
      federation_id: "MG"
    },
    {
      name: "Nova Lima",
      code: "UNI31223",
      cep: "30130135",
      street: "Rua Rio Grande do Norte",
      address_number: "312",
      neighborhood: "Funcionários",
      complement: "de 671/672 a 1229/1230",
      city: "Belo Horizonte",
      federation_id: "MG"
    },
    {
      name: "Contagem",
      code: "UNI87364",
      cep: "30130135",
      street: "Rua Rio Grande do Norte",
      address_number: "312",
      neighborhood: "Funcionários",
      complement: "de 671/672 a 1229/1230",
      city: "Belo Horizonte",
      federation_id: "MG"
    },
    {
      name: "Gutierrez",
      code: "UNI00938",
      cep: "30130135",
      street: "Rua Rio Grande do Norte",
      address_number: "312",
      neighborhood: "Funcionários",
      complement: "de 671/672 a 1229/1230",
      city: "Belo Horizonte",
      federation_id: "MG"
    }
])

institution.branches.each do |branch|
  course_names = ["Engenharia elétrica", "Engenharia civil", "Sistemas de informação", "Ciência da computação"]
  course_names.each do |course_name|
    course = branch.courses.create(name: course_name, code: SecureRandom.hex(2).upcase)
    subject_names = ["Cálculo I", "Cálculo II", "Cálculo III", "Introdução a Física", "Geometria analítica e Álgebra linear", "Programação e Desenvolvimento de Software I", "Programação e Desenvolvimento de Software II"]
    subject_names.each do |subject_name|
      unit = branch.units.create(course: course, name: subject_name, code: SecureRandom.hex(2).upcase)
      unit.groups.create(code: %w[TW1 TW2 TOL TZ1 TZ2].sample)
    end
  end

  grade = branch.grades.create(title: "2019/01", begin_date: Date.today, end_date: Date.today + 4.months)

  user2 = User.create(email: Faker::Internet.email, password: "qweqwe", tax_id: Faker::IDNumber.brazilian_citizen_number)
  teacher = institution.teachers.create(user: user2, name: Faker::Name.name)
  teacher.save!

  (15..19).each do |day|
    course = branch.courses.first
    grades_units = []
    # diurno
    unit = branch.units.where(course: course).sample
    grades_units << grade.grade_units.create(unit: unit, group: unit.groups.sample, starts_on: DateTime.new(Date.today.year, 4, day, 7, 0, 0), ends_on: DateTime.new(Date.today.year, 4, day, 8, 40, 0))
    unit = branch.units.where(course: course).sample
    grades_units << grade.grade_units.create(unit: unit, group: unit.groups.sample, starts_on: DateTime.new(Date.today.year, 4, day, 9, 0, 0), ends_on: DateTime.new(Date.today.year, 4, day, 10, 40, 0))
    unit = branch.units.where(course: course).sample
    grades_units << grade.grade_units.create(unit: unit, group: unit.groups.sample, starts_on: DateTime.new(Date.today.year, 4, day, 11, 0, 0), ends_on: DateTime.new(Date.today.year, 4, day, 12, 0, 0))

    # noturno
    unit = branch.units.where(course: course).sample
    grades_units << grade.grade_units.create(unit: unit, group: unit.groups.sample, starts_on: DateTime.new(Date.today.year, 4, day, 17, 0, 0), ends_on: DateTime.new(Date.today.year, 4, day, 18, 40, 0))
    unit = branch.units.where(course: course).sample
    grades_units << grade.grade_units.create(unit: unit, group: unit.groups.sample, starts_on: DateTime.new(Date.today.year, 4, day, 15, 0, 0), ends_on: DateTime.new(Date.today.year, 4, day, 16, 40, 0))
    unit = branch.units.where(course: course).sample
    grades_units << grade.grade_units.create(unit: unit, group: unit.groups.sample, starts_on: DateTime.new(Date.today.year, 4, day, 19, 0, 0), ends_on: DateTime.new(Date.today.year, 4, day, 20, 40, 0))
    unit = branch.units.where(course: course).sample
    grades_units << grade.grade_units.create(unit: unit, group: unit.groups.sample, starts_on: DateTime.new(Date.today.year, 4, day, 21, 0, 0), ends_on: DateTime.new(Date.today.year, 4, day, 22, 40, 0))

    20.times do |index|
      user1 = User.create(email: Faker::Internet.email, password: "qweqwe", tax_id: Faker::IDNumber.brazilian_citizen_number)
      index % 5 == 0 ? name = Faker::GreekPhilosophers.name : name = Faker::Name.name
      student = branch.students.create(user: user1, name: name, enrollment_id: SecureRandom.hex(10).upcase)
      student.grade_units << grades_units
    end
  end
end
