desc "Generate type_scholarship's instances"
task generate_type_scholarships: :environment do
  TypeScholarship.create!(scholarship: :agreement)
  TypeScholarship.create!(scholarship: :subsidized)
end
