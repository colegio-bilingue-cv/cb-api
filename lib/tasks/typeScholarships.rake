desc "Generates 4 default typeScholarships instances"
task :generateTypeScholarships do
    TypeScholarship.create!(:description => "Licitación")
    TypeScholarship.create!(:description => "Bonificada")
    TypeScholarship.create!(:description => "Convenio")
    TypeScholarship.create!(:description => "Especial")
end
