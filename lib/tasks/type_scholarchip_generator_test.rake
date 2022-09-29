desc "Generate type_scholarship's instances"
task :generate_type_scholarships => [ :environment ] do
  require "#{Rails.root}/app/models/type_scholarship.rb"
  TypeScholarship.create!(:description => "una descripcion", :type_s => 1)
  TypeScholarship.create!(:description => "otra descripcion", :type_s => 1)
  TypeScholarship.create!(:description => "hola", :type_s => 3)
end