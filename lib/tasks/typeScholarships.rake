desc "Generates 5 typeScholarships instances"
task :generateTypeScholarships do
    for index in 0..4
        TypeScholarship.create(:description => index)
    end
end
