#!/bin/sh
bin/rails db:reset
echo "Creando ciclos y preguntas"
bundle exec rake generate_cicles_questions
echo "Creando usuarios y grupos"
bundle exec rake generate_users_groups
echo "Creando metodos de pagos"
bundle exec rake generate_payment_methods
echo "Creando tipos de escolaridad"
bundle exec rake generate_type_scholarships
echo "Lets Rock!"
