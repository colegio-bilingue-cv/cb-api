desc "Generate type_scholarship's instances"
task generate_type_scholarships: :environment do
  TypeScholarship.create!(description: 'bidding1', scholarship: :bidding)
  TypeScholarship.create!(description: 'bidding2', scholarship: :bidding)
  TypeScholarship.create!(description: 'special1', scholarship: :special)
  TypeScholarship.create!(scholarship: :agreement)
  TypeScholarship.create!(scholarship: :subsidized)
end
