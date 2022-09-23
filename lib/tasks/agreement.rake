desc "Generates Agreement None"
task :agreementNone do
    AgreementType.create(:description => "None")
end
