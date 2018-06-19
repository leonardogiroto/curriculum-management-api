namespace :curriculums do
  desc "Importa para a base de dados curriculums do JSON disponibilizado para Load Inicial"

  task import: :environment do
    puts "Importando Currículos..."

    json_path = Rails.root.join("lib", "seeds", "generated.json")

    json = open(json_path).read
    curriculums = JSON.parse(json)
    
    curriculums.each do |curr|
      newCurriculum = Curriculum.create!(
        active: curr["isActive"],
        created_at: curr["createdAt"],
        picture: curr["picture"],
        birthdate: curr["birthDate"],
        name: curr["name"],
        gender: curr["gender"],
        email: curr["email"],
        phone: curr["phone"],
        address: curr["address"],
        latitude: curr["latitude"].to_f,
        longitude: curr["longitude"].to_f,
        tags: curr["tags"].join(", "),
        score: 1 + (rand * 9)
      )

      curr["formations"].each do |formation|
        Formation.create!(
          institution: formation["institution"],
          course: formation["course"],
          concluded: formation["isConcluded"],
          start_date: formation["startDate"],
          end_date: formation["endDate"],
          curriculum_id: newCurriculum.id
        )
      end

      curr["professionalExperiences"].each do |exp|
        ProfessionalExperience.create!(
          company_name: exp["companyName"],
          role: exp["role"],
          start_date: exp["startDate"],
          end_date: exp["endDate"],
          curriculum_id: newCurriculum.id
        )
      end

    end

    puts "Currículos importados com sucesso!"
    puts "Total: " + curriculums.length.to_s
  end

end
