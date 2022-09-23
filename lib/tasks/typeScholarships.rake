desc "Generates 4 default typeScholarships instances"
task :generateTypeScholarships => [ :environment ] do
    require "#{Rails.root}/app/models/type_scholarship.rb"
    TypeScholarship.create!(:description => "Licitación")
    TypeScholarship.create!(:description => "Bonificada")
    TypeScholarship.create!(:description => "Convenio")
    TypeScholarship.create!(:description => "Especial")
end
