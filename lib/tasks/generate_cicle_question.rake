desc "Generate cicles's instances and question's instances"
task generate_cicles_questions: :environment do
    #CATEGORIES
    category_basic = Category.create!(name: 'Basico')
    category_family = Category.create!(name: 'Entorno Familiar')
    category_technology = Category.create!(name: 'Aspectos Tecnologicos')
    category_pregnancy = Category.create!(name: 'Aspectos del embarazo y nacimiento')
    category_development = Category.create!(name: 'Indicadores del desarrollo')
    category_home = Category.create!(name: 'En el hogar')
    category_study = Category.create!(name: 'Sobre el estudio')
    category_interests = Category.create!(name: 'Sus intereses')
    category_parents_vision = Category.create!(name: '¿Cómo ven los padres al niño?')
    category_feeding = Category.create!(name: 'Alimentación')
    category_sleep = Category.create!(name: 'Sueño')
    category_play = Category.create!(name: 'Juego')
    category_illness = Category.create!(name: 'Enfermedades')
    category_interconsulting = Category.create!(name: 'interconsultas')
    category_observation = Category.create!(name: 'Observaciones de importancia')
    category_education_proyect = Category.create!(name: 'Proyecto Educativo')
    category_authorization_image = Category.create!(name: 'Autorización de imagen')

    #CYCLES
    maternal = Cicle.create!(name: "Maternal")
    primary = Cicle.create!(name: "Inicial/Primaria")
    secondary = Cicle.create!(name: "Secundaria")

    #GRADES
    Grade.create!(name: 'Nivel 0', cicle: maternal)
    Grade.create!(name: 'Nivel 1', cicle: maternal)
    Grade.create!(name: 'Nivel 2', cicle: maternal)
    Grade.create!(name: 'Nivel 3', cicle: primary)
    Grade.create!(name: 'Nivel 4', cicle: primary)
    Grade.create!(name: 'Nivel 5', cicle: primary)
    Grade.create!(name: '1ero', cicle: primary)
    Grade.create!(name: '2do', cicle: primary)
    Grade.create!(name: '3ero', cicle: primary)
    Grade.create!(name: '4to', cicle: primary)
    Grade.create!(name: '5to', cicle: primary)
    Grade.create!(name: '6to', cicle: primary)
    Grade.create!(name: '1 CBU', cicle: secondary)
    Grade.create!(name: '2 CBU', cicle: secondary)
    Grade.create!(name: '3 CBU', cicle: secondary)

    #QUESTIONS

    #BASICS
    category_basic.questions.create!(text: 'Nombre completo:', cicles: [maternal, primary, secondary])
    category_basic.questions.create!(text: 'En casa lo llaman:', cicles: [maternal, primary, secondary])
    category_basic.questions.create!(text: 'Fecha de nacimiento:', cicles: [maternal, primary, secondary])
    category_basic.questions.create!(text: '¿Quiénes concurren a entrevista?', cicles: [maternal, primary, secondary])
    category_basic.questions.create!(text: '¿Asistió a instituciones anteriores?', cicles: [maternal, primary, secondary])
    category_basic.questions.create!(text: '¿Desde que edad?', cicles: [maternal, primary, secondary])
    category_basic.questions.create!(text: 'Nombre de instituciones anteriores', cicles: [maternal, primary, secondary])
    category_basic.questions.create!(text: '¿Lo cuida o cuidó una persona en casa que no sea mamá o papá? ', cicles: [maternal])
    category_basic.questions.create!(text: '¿Se realizó test o diagnóstico?', cicles: [secondary])
    category_basic.questions.create!(text: 'Escolaridad / Comentarios Director', cicles: [primary, secondary])
    
    #FAMILY
    category_family.questions.create!(text: '¿Con quién vive el alumno/a?', cicles:[maternal, primary, secondary])
    category_family.questions.create!(text: '¿Tiene hermanos?', cicles: [maternal, primary, secondary])
    category_family.questions.create!(text: '¿Los hermanos concurren a nuestra institución?', cicles: [maternal, primary, secondary])
    category_family.questions.create!(text: '¿Ubicación del alumno/a en el orden de hermanos?', cicles: [maternal, primary, secondary])
    category_family.questions.create!(text: '¿Ubicación del alumno/a en el orden de hermanos?', cicles: [maternal, primary, secondary])
    category_family.questions.create!(text: 'Hermanos (Edades y Sexo):', cicles: [maternal, primary, secondary])
    category_family.questions.create!(text: '¿En caso de separación: qué edad tenía el alumno y como lo transitó?', cicles: [maternal, primary, secondary])
    category_family.questions.create!(text: 'En caso de hermanos/as, ¿cómo es el vínculo con ellos/as?', cicles: [maternal, primary, secondary])
    category_family.questions.create!(text: '¿Tiene vínculos con tíos,  primos, abuelos?', cicles: [maternal, primary, secondary])
    category_family.questions.create!(text: 'Hecho o situación familiar que amerite informar', cicles: [maternal, primary, secondary])

    #TECHLOOGY
    category_technology.questions.create!(text: '¿Cuántas laptops hay en la vivienda? (No incluir ceibal)', cicles: [maternal, primary, secondary])
    category_technology.questions.create!(text: '¿Cuántas pc fijas hay en la vivienda?', cicles: [maternal, primary, secondary])
    category_technology.questions.create!(text: '¿Cuántas tablets hay en la vivienda? (No incluir ceibal)', cicles: [maternal, primary, secondary])
    category_technology.questions.create!(text: '¿Cuántas laptop/tablets CEIBAL hay en la vivienda?', cicles: [maternal, primary, secondary])
    category_technology.questions.create!(text: '¿En el hogar hay acceso a internet?', cicles: [maternal, primary, secondary])
    category_technology.questions.create!(text: '¿Tiene smartphone o celular inteligente con acceso a internet desde su hogar?', cicles: [maternal, primary, secondary])

    #PREGNANCY
    category_pregnancy.questions.create!(text: '¿Cómo fue el embarazo? ¿Tuvieron que hacer tratamiento?', cicles: [maternal, primary, secondary])
    category_pregnancy.questions.create!(text: '¿Cómo vivieron el momento del nacimiento?', cicles: [maternal, primary, secondary])
    category_pregnancy.questions.create!(text: '¿Fue un nacimiento a término? En caso negativo, ¿de cuántas semanas?', cicles: [maternal, primary, secondary])
    category_pregnancy.questions.create!(text: '¿Fue parto vaginal o césarea?', cicles: [maternal, primary, secondary])
    category_pregnancy.questions.create!(text: '¿Hubo alguna complicación al nacer?', cicles: [maternal, primary, secondary])
    category_pregnancy.questions.create!(text: 'En caso de adopción, ¿cómo vivieron el proceso?', cicles: [maternal, primary, secondary])

    #DEVELOPMENT
    category_development.questions.create!(text: '¿Gatea? ¿Desde cuándo?', cicles: [maternal])
    category_development.questions.create!(text: '¿Marcha? ¿Desde cuándo?', cicles: [maternal])
    category_development.questions.create!(text: '¿Vocaliza, balbucea? ¿Desde cuándo?', cicles: [maternal])
    category_development.questions.create!(text: '¿Si se equivoca al hablar es corregido? ¿cómo?', cicles: [maternal])

    #HOME
    category_home.questions.create!(text: '¿Colabora en tareas de la casa?', cicles: [secondary])
    category_home.questions.create!(text: '¿Con qué integrante de la flia estás más horas?', cicles: [secondary])
    category_home.questions.create!(text: '¿Con quien conversas de tus problemas?', cicles: [secondary])
    category_home.questions.create!(text: '¿Qué haces en tu tiempo libre?', cicles: [secondary])

    #STUDY
    category_study.questions.create!(text: '¿Necesitas apoyo o lo haces en forma independiente?', cicles: [secondary])
    category_study.questions.create!(text: '¿Has estudiado en grupo o siempre solo?', cicles: [secondary])
    category_study.questions.create!(text: '¿Tienes alguna dificultad en algún área?', cicles: [secondary])
    category_study.questions.create!(text: '¿Te distraes con facilidad o te puedes concentrar por un largo período?', cicles: [secondary])
    category_study.questions.create!(text: '¿Sabes el motivo de esta?', cicles: [secondary])
    category_study.questions.create!(text: '¿Dispones de textos, materiales, P.C, etc?', cicles: [secondary])
    category_study.questions.create!(text: '¿Cómo organizas el tiempo para las tareas domiciliarias?', cicles: [secondary])
    category_study.questions.create!(text: '¿Quieres agregar algo que a tu juicio favorezca o dificulte tu aprendizaje?', cicles: [secondary])
    
    #INTERSTS
    category_interests.questions.create!(text: '¿A qué lugares de reunión concurres habitualmente?', cicles: [secondary])
    category_interests.questions.create!(text: '¿Tienes amigos? ¿De dónde son?', cicles: [secondary])
    category_interests.questions.create!(text: '¿Practicas algún deporte, idioma, actividad musical, etc.? ¿Dónde?', cicles: [secondary])
    category_interests.questions.create!(text: 'En tu tiempo libre: ¿Miras T,V.? ¿Escuchas radio?¿Lees?¿Chateas?', cicles: [secondary])
    category_interests.questions.create!(text: '¿A partir de qué hora te encuentras en casa con tu familia?', cicles: [secondary])
    category_interests.questions.create!(text: '¿En qué actividades has obtenido la mayor satisfacción?', cicles: [secondary])
    category_interests.questions.create!(text: '¿En qué actividades te has sentido derrotado?', cicles: [secondary])
    category_interests.questions.create!(text: '¿Tienes alguna preocupación actual?', cicles: [secondary])
    category_interests.questions.create!(text: '¿Qué cosas te hacen enojar?', cicles: [secondary])
    category_interests.questions.create!(text: '¿Qué cosas te ponen contento?', cicles: [secondary])
    category_interests.questions.create!(text: '¿Tienes facilidad para relacionarte con los chicos?', cicles: [secondary])
    category_interests.questions.create!(text: '¿Y con los adultos?', cicles: [secondary])
    category_interests.questions.create!(text: 'Propone alguna actividad que  consideres que no puede faltar en el liceo', cicles: [secondary])

    #PARENTS VISION
    category_parents_vision.questions.create!(text: '¿Comunica lo que siente?', cicles: [maternal])
    category_parents_vision.questions.create!(text: '¿Hace rabietas? ¿Qué lo enoja?', cicles: [maternal, primary])
    category_parents_vision.questions.create!(text: '¿Hay puesta de límites? En caso de afirmativo, ¿cómo lo manejan, estrategias que usan?', cicles: [maternal, primary])
    category_parents_vision.questions.create!(text: '¿Le tiene miedo a algo?', cicles: [maternal, primary])
    category_parents_vision.questions.create!(text: '¿Uso de pantallas? ¿cuántas horas? ¿qué mira?', cicles: [maternal, primary])
    category_parents_vision.questions.create!(text: '¿Comunica lo que siente?', cicles: [primary])
    category_parents_vision.questions.create!(text: 'Cómo negocian  los NO en el hogar?', cicles: [primary])
    
    #FEEDING
    category_feeding.questions.create!(text: 'Los primeros tiempos fue ¿lactancia exclusiva?', cicles: [maternal])
    category_feeding.questions.create!(text: 'Si dejó el pecho, ¿cuándo lo hizo?', cicles: [maternal])
    category_feeding.questions.create!(text: '¿Tomó/toma mamadera?', cicles: [maternal])
    category_feeding.questions.create!(text: '¿Usó o usa chupete?', cicles: [maternal])
    category_feeding.questions.create!(text: 'Alimentación sólida: ¿Qué preferencia tiene? ¿horarios de la comida?', cicles: [maternal, primary])
    category_feeding.questions.create!(text: '¿Quién le da de comer?', cicles: [maternal])
    category_feeding.questions.create!(text: 'En caso de comer solo, ¿usa utensilios? ¿Come con la mano?', cicles: [maternal])

    #SLEEP
    category_sleep.questions.create!(text: '¿Cómo concilia el sueño? ¿Solo? ¿Lo hamacan? ¿En el coche? ¿colecho?', cicles: [maternal, primary])
    category_sleep.questions.create!(text: '¿Duerme solo?', cicles: [maternal, primary])
    category_sleep.questions.create!(text: '¿Duerme siestas?', cicles: [primary])

    #PLAY
    category_play.questions.create!(text: '¿A qué juega? ¿con quién juega? ', cicles: [maternal, primary])
    category_play.questions.create!(text: '¿Le leen cuentos?', cicles: [maternal])
    category_play.questions.create!(text: '¿Le cantan? ¿Cuándo?', cicles: [maternal])
    category_play.questions.create!(text: '¿Tiene algún objeto de apego?', cicles: [maternal])
    category_play.questions.create!(text: '¿Qué lugares frecuenta/conoce? (plaza, casa de algún familiar/playa/patio/campo, etc.)', cicles: [maternal])

    #ILLNESS
    category_illness.questions.create!(text: 'Escarlatina', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: 'Sarampión', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: 'Varicela', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: 'Rubeola', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: 'Paperas', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: 'Tos convulsa', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: '¿Tuvo o tiene enfermedades importantes? ¿Cuáles?', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: '¿Sufre enfermedades crónicas? ¿Cuáles?', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: '¿Toma medicamentos regularmente? ¿Cuáles?', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: '¿Existen consecuencias de accidentes? ¿Cuáles?', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: 'Alergias o intolerancia a algún alimento:', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: 'Otra información importante:', cicles: [maternal, primary, secondary])
    category_illness.questions.create!(text: 'Comentarios Director', cicles: [maternal, primary, secondary])

    #INTERCONSULTING
    category_interconsulting.questions.create!(text: 'Foniatra', cicles: [maternal, primary, secondary])
    category_interconsulting.questions.create!(text: 'Psicomotricista', cicles: [maternal, primary, secondary])
    category_interconsulting.questions.create!(text: 'Psicopedagogo', cicles: [maternal, primary, secondary])
    category_interconsulting.questions.create!(text: 'Psicólogo', cicles: [maternal, primary, secondary])
    category_interconsulting.questions.create!(text: 'Psiquiatra', cicles: [maternal, primary, secondary])
    category_interconsulting.questions.create!(text: 'Neuropediatra', cicles: [maternal, primary, secondary])
    category_interconsulting.questions.create!(text: '¿Desea realizar algún comentario al respecto?', cicles: [maternal, primary, secondary])
    category_interconsulting.questions.create!(text: 'Comentarios Director', cicles: [maternal, primary, secondary])
    category_interconsulting.questions.create!(text: 'Adjuntar informes', cicles: [maternal, primary, secondary])

    #OBSEVARTIONS
    category_observation.questions.create!(text: 'Respecto a los cuidados diarios ¿quién se ocupa de qué? ¿baño? ¿sueño?', cicles: [maternal])
    category_observation.questions.create!(text: 'Relación con otros miembros de la familia', cicles: [maternal])
    category_observation.questions.create!(text: 'Preocupaciones entorno a la crianza y el desarrollo de su hijo/a', cicles: [maternal, primary, secondary])
    category_observation.questions.create!(text: 'Aspectos importantes que debemos considerar', cicles: [maternal, primary, secondary])
    category_observation.questions.create!(text: 'Lenguaje y comunicación', cicles: [maternal, primary, secondary])
    category_observation.questions.create!(text: '¿Qué le gusta hacer?', cicles: [primary, secondary])
    category_observation.questions.create!(text: '¿Qué talento presenta?', cicles: [primary, secondary])
    category_observation.questions.create!(text: '¿Cómo define a su hijo? Mi hijo/a es…', cicles: [maternal, primary, secondary])

    #EDUCATION PROYECT
    category_education_proyect.questions.create!(text: '¿Cómo llegó a conocer nuestra institución?', cicles: [maternal, primary, secondary])
    category_education_proyect.questions.create!(text: '¿Qué conocimientos, habilidades y/o actutydes fundamentales cree que deben desarrollarse en el proceso de aprendizaje de su hijo/a para lograr un  alto desempeño en la complejidad y desafíos del mundo actual?', cicles: [maternal, primary, secondary])
    category_education_proyect.questions.create!(text: '¿Por qué considera importante una propuesta bilingüe en la formación de su hijo/a?', cicles: [maternal, primary, secondary])
    category_education_proyect.questions.create!(text: 'Detalle aquí otra información que crea importante y que pueda contribuir a una atención eficiente e integral del alumno/a:', cicles: [maternal, primary, secondary])
    category_education_proyect.questions.create!(text: '¿Qué expectativa pedagógica, vincular, etc, tiene la familia respecto a la Institución Educativa?', cicles: [maternal, primary, secondary])
    category_education_proyect.questions.create!(text: '¿Qué no puede faltar en el vínculo con la Institución?', cicles: [primary])
    category_education_proyect.questions.create!(text: '¿Qué opina de los grupos de WhatsApp de padres?', cicles: [primary])
    category_education_proyect.questions.create!(text: '¿Qué expectativa pedagógica, vincular, etc, tiene la familia respecto a la Institución Educativa?', cicles: [secondary])
    
    #AUTHORIZATION IMAGE
    category_authorization_image.questions.create!(text: '¿Autoriza imagen?', cicles: [maternal, primary, secondary])
    category_authorization_image.questions.create!(text: 'Adjuntar documento firmado', cicles: [maternal, primary, secondary])

end
