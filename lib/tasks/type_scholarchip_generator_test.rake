desc "Generate type_scholarship's instances"
task generate_type_scholarships: :environment do
  TypeScholarship.create!(description: 'test1', scholarship: :bidding)
  TypeScholarship.create!(description: 'test2', scholarship: :bidding)
  TypeScholarship.create!(description: 'test2', scholarship: :special)
end
