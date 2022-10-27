desc "Generate grades and cicles(due to dependecies)"
task generate_grades_cicles: :environment do
    maternal = Cicle.create!(name: 'Maternal')
    inicialPrimaria = Cicle.create!(name: 'Inicial/Primaria')
    secundaria = Cicle.create!(name: 'Secundaria')
    Grade.create!(name: 'Nivel 0', cicle_id: maternal.id)
    Grade.create!(name: 'Nivel 1', cicle_id: maternal.id)
    Grade.create!(name: 'Nivel 2', cicle_id: maternal.id)
    Grade.create!(name: 'Nivel 3', cicle_id: inicialPrimaria.id)
    Grade.create!(name: 'Nivel 4', cicle_id: inicialPrimaria.id)
    Grade.create!(name: 'Nivel 5', cicle_id: inicialPrimaria.id)
    Grade.create!(name: '1ero', cicle_id: inicialPrimaria.id)
    Grade.create!(name: '2do', cicle_id: inicialPrimaria.id)
    Grade.create!(name: '3ero', cicle_id: inicialPrimaria.id)
    Grade.create!(name: '4to', cicle_id: inicialPrimaria.id)
    Grade.create!(name: '5to', cicle_id: inicialPrimaria.id)
    Grade.create!(name: '6to', cicle_id: inicialPrimaria.id)
    Grade.create!(name: '1 CBU', cicle_id: secundaria.id)
    Grade.create!(name: '2 CBU', cicle_id: secundaria.id)
    Grade.create!(name: '3 CBU', cicle_id: secundaria.id)
end

