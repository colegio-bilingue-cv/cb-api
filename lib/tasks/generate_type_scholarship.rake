desc "Generate type_scholarship's instances"
task generate_type_scholarships: :environment do
  TypeScholarship.create!(scholarship: :special)
  TypeScholarship.create!(scholarship: :subsidized)
end
