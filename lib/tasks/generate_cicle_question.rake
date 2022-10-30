desc "Generate cicles's instances and question's instances"
task generate_cicles_questions: :environment do
    #CATEGORIES
    categoryBasic = Category.create!(name: 'Basico')
    categoryFamily = Category.create!(name: 'Entorno Familiar')
    categoryTechnology = Category.create!(name: 'Aspectos Tecnologicos')
    categoryPregnancy = Category.create!(name: 'Aspectos del embarazo y nacimiento')
    categoryDevelopment = Category.create!(name: 'Indicadores del desarrollo')
    categoryHome = Category.create!(name: 'En el hogar')
    categoryStudy = Category.create!(name: 'Sobre el estudio')
    categoryInterests = Category.create!(name: 'Sus intereses')
    categoryParentsVision = Category.create!(name: '¿Cómo ven los padres al niño?')
    categoryFeeding = Category.create!(name: 'Alimentación')
    categorySleep = Category.create!(name: 'Sueño')
    categoryPlay = Category.create!(name: 'Juego')
    categoryIllness = Category.create!(name: 'Enfermedades')
    categoryInterconsulting = Category.create!(name: 'interconsultas')
    categoryObservation = Category.create!(name: 'Observaciones de importancia')
    categoryEducationProyect = Category.create!(name: 'Proyecto Educativo')
    categoryAuthorizationImage = Category.create!(name: 'Autorización de imagen')

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
    categoryBasic.questions.create!(text: 'Nombre completo:', cicles: [maternal, primary, secondary])
    categoryBasic.questions.create!(text: 'En casa lo llaman:', cicles: [maternal, primary, secondary])
    categoryBasic.questions.create!(text: 'Fecha de nacimiento:', cicles: [maternal, primary, secondary])
    categoryBasic.questions.create!(text: '¿Quiénes concurren a entrevista?', cicles: [maternal, primary, secondary])
    categoryBasic.questions.create!(text: '¿Asistió a instituciones anteriores?', cicles: [maternal, primary, secondary])
    categoryBasic.questions.create!(text: '¿Desde que edad?', cicles: [maternal, primary, secondary])
    categoryBasic.questions.create!(text: 'Nombre de instituciones anteriores', cicles: [maternal, primary, secondary])
    categoryBasic.questions.create!(text: '¿Lo cuida o cuidó una persona en casa que no sea mamá o papá? ', cicles: [maternal])
    categoryBasic.questions.create!(text: '¿Se realizó test o diagnóstico?', cicles: [secondary])
    categoryBasic.questions.create!(text: 'Escolaridad / Comentarios Director', cicles: [primary, secondary])
    
    #FAMILY
    categoryFamily.questions.create!(text: '¿Con quién vive el alumno/a?', cicles:[maternal, primary, secondary])
    categoryFamily.questions.create!(text: '¿Tiene hermanos?', cicles: [maternal, primary, secondary])
    categoryFamily.questions.create!(text: '¿Los hermanos concurren a nuestra institución?', cicles: [maternal, primary, secondary])
    categoryFamily.questions.create!(text: '¿Ubicación del alumno/a en el orden de hermanos?', cicles: [maternal, primary, secondary])
    categoryFamily.questions.create!(text: '¿Ubicación del alumno/a en el orden de hermanos?', cicles: [maternal, primary, secondary])
    categoryFamily.questions.create!(text: 'Hermanos (Edades y Sexo):', cicles: [maternal, primary, secondary])
    categoryFamily.questions.create!(text: '¿En caso de separación: qué edad tenía el alumno y como lo transitó?', cicles: [maternal, primary, secondary])
    categoryFamily.questions.create!(text: 'En caso de hermanos/as, ¿cómo es el vínculo con ellos/as?', cicles: [maternal, primary, secondary])
    categoryFamily.questions.create!(text: '¿Tiene vínculos con tíos,  primos, abuelos?', cicles: [maternal, primary, secondary])
    categoryFamily.questions.create!(text: 'Hecho o situación familiar que amerite informar', cicles: [maternal, primary, secondary])

    #TECHLOOGY
    categoryTechnology.questions.create!(text: '¿Cuántas laptops hay en la vivienda? (No incluir ceibal)', cicles: [maternal, primary, secondary])
    categoryTechnology.questions.create!(text: '¿Cuántas pc fijas hay en la vivienda?', cicles: [maternal, primary, secondary])
    categoryTechnology.questions.create!(text: '¿Cuántas tablets hay en la vivienda? (No incluir ceibal)', cicles: [maternal, primary, secondary])
    categoryTechnology.questions.create!(text: '¿Cuántas laptop/tablets CEIBAL hay en la vivienda?', cicles: [maternal, primary, secondary])
    categoryTechnology.questions.create!(text: '¿En el hogar hay acceso a internet?', cicles: [maternal, primary, secondary])
    categoryTechnology.questions.create!(text: '¿Tiene smartphone o celular inteligente con acceso a internet desde su hogar?', cicles: [maternal, primary, secondary])

    #PREGNANCY
    categoryPregnancy.questions.create!(text: '¿Cómo fue el embarazo? ¿Tuvieron que hacer tratamiento?', cicles: [maternal, primary, secondary])
    categoryPregnancy.questions.create!(text: '¿Cómo vivieron el momento del nacimiento?', cicles: [maternal, primary, secondary])
    categoryPregnancy.questions.create!(text: '¿Fue un nacimiento a término? En caso negativo, ¿de cuántas semanas?', cicles: [maternal, primary, secondary])
    categoryPregnancy.questions.create!(text: '¿Fue parto vaginal o césarea?', cicles: [maternal, primary, secondary])
    categoryPregnancy.questions.create!(text: '¿Hubo alguna complicación al nacer?', cicles: [maternal, primary, secondary])
    categoryPregnancy.questions.create!(text: 'En caso de adopción, ¿cómo vivieron el proceso?', cicles: [maternal, primary, secondary])

    #DEVELOPMENT
    categoryDevelopment.questions.create!(text: '¿Gatea? ¿Desde cuándo?', cicles: [maternal])
    categoryDevelopment.questions.create!(text: '¿Marcha? ¿Desde cuándo?', cicles: [maternal])
    categoryDevelopment.questions.create!(text: '¿Vocaliza, balbucea? ¿Desde cuándo?', cicles: [maternal])
    categoryDevelopment.questions.create!(text: '¿Si se equivoca al hablar es corregido? ¿cómo?', cicles: [maternal])

    #HOME
    categoryHome.questions.create!(text: '¿Colabora en tareas de la casa?', cicles: [secondary])
    categoryHome.questions.create!(text: '¿Con qué integrante de la flia estás más horas?', cicles: [secondary])
    categoryHome.questions.create!(text: '¿Con quien conversas de tus problemas?', cicles: [secondary])
    categoryHome.questions.create!(text: '¿Qué haces en tu tiempo libre?', cicles: [secondary])

    #STUDY
    categoryStudy.questions.create!(text: '¿Necesitas apoyo o lo haces en forma independiente?', cicles: [secondary])
    categoryStudy.questions.create!(text: '¿Has estudiado en grupo o siempre solo?', cicles: [secondary])
    categoryStudy.questions.create!(text: '¿Tienes alguna dificultad en algún área?', cicles: [secondary])
    categoryStudy.questions.create!(text: '¿Te distraes con facilidad o te puedes concentrar por un largo período?', cicles: [secondary])
    categoryStudy.questions.create!(text: '¿Sabes el motivo de esta?', cicles: [secondary])
    categoryStudy.questions.create!(text: '¿Dispones de textos, materiales, P.C, etc?', cicles: [secondary])
    categoryStudy.questions.create!(text: '¿Cómo organizas el tiempo para las tareas domiciliarias?', cicles: [secondary])
    categoryStudy.questions.create!(text: '¿Quieres agregar algo que a tu juicio favorezca o dificulte tu aprendizaje?', cicles: [secondary])
    
    #INTERSTS
    categoryInterests.questions.create!(text: '¿A qué lugares de reunión concurres habitualmente?', cicles: [secondary])
    categoryInterests.questions.create!(text: '¿Tienes amigos? ¿De dónde son?', cicles: [secondary])
    categoryInterests.questions.create!(text: '¿Practicas algún deporte, idioma, actividad musical, etc.? ¿Dónde?', cicles: [secondary])
    categoryInterests.questions.create!(text: 'En tu tiempo libre: ¿Miras T,V.? ¿Escuchas radio?¿Lees?¿Chateas?', cicles: [secondary])
    categoryInterests.questions.create!(text: '¿A partir de qué hora te encuentras en casa con tu familia?', cicles: [secondary])
    categoryInterests.questions.create!(text: '¿En qué actividades has obtenido la mayor satisfacción?', cicles: secondary)
    categoryInterests.questions.create!(text: '¿En qué actividades te has sentido derrotado?', cicles: [secondary])
    categoryInterests.questions.create!(text: '¿Tienes alguna preocupación actual?', cicles: [secondary])
    categoryInterests.questions.create!(text: '¿Qué cosas te hacen enojar?', cicles: [secondary])
    categoryInterests.questions.create!(text: '¿Qué cosas te ponen contento?', cicles: [secondary])
    categoryInterests.questions.create!(text: '¿Tienes facilidad para relacionarte con los chicos?', cicles: [secondary])
    categoryInterests.questions.create!(text: '¿Y con los adultos?', cicles: [secondary])
    categoryInterests.questions.create!(text: 'Propone alguna actividad que  consideres que no puede faltar en el liceo', cicles: [secondary])

    #PARENTS VISION
    categoryParentsVision.questions.create!(text: '¿Comunica lo que siente?', cicles: [maternal])
    categoryParentsVision.questions.create!(text: '¿Hace rabietas? ¿Qué lo enoja?', cicles: [maternal, primary])
    categoryParentsVision.questions.create!(text: '¿Hay puesta de límites? En caso de afirmativo, ¿cómo lo manejan, estrategias que usan?', cicles: [maternal, primary])
    categoryParentsVision.questions.create!(text: '¿Le tiene miedo a algo?', cicles: [maternal, primary])
    categoryParentsVision.questions.create!(text: '¿Uso de pantallas? ¿cuántas horas? ¿qué mira?', cicles: [maternal, primary])
    categoryParentsVision.questions.create!(text: '¿Comunica lo que siente?', cicles: [primary])
    categoryParentsVision.questions.create!(text: 'Cómo negocian  los NO en el hogar?', cicles: [primary])
    
    #FEEDING
    categoryFeeding.questions.create!(text: 'Los primeros tiempos fue ¿lactancia exclusiva?', cicles: [maternal])
    categoryFeeding.questions.create!(text: 'Si dejó el pecho, ¿cuándo lo hizo?', cicles: [maternal])
    categoryFeeding.questions.create!(text: '¿Tomó/toma mamadera?', cicles: [maternal])
    categoryFeeding.questions.create!(text: '¿Usó o usa chupete?', cicles: [maternal])
    categoryFeeding.questions.create!(text: 'Alimentación sólida: ¿Qué preferencia tiene? ¿horarios de la comida?', cicles: [maternal, primary])
    categoryFeeding.questions.create!(text: '¿Quién le da de comer?', cicles: [maternal])
    categoryFeeding.questions.create!(text: 'En caso de comer solo, ¿usa utensilios? ¿Come con la mano?', cicles: [maternal])

    #SLEEP
    categorySleep.questions.create!(text: '¿Cómo concilia el sueño? ¿Solo? ¿Lo hamacan? ¿En el coche? ¿colecho?', cicles: [maternal, primary])
    categorySleep.questions.create!(text: '¿Duerme solo?', cicles: [maternal, primary])
    categorySleep.questions.create!(text: '¿Duerme siestas?', cicles: [primary])

    #PLAY
    categoryPlay.questions.create!(text: '¿A qué juega? ¿con quién juega? ', cicles: [maternal, primary])
    categoryPlay.questions.create!(text: '¿Le leen cuentos?', cicles: [maternal])
    categoryPlay.questions.create!(text: '¿Le cantan? ¿Cuándo?', cicles: [maternal])
    categoryPlay.questions.create!(text: '¿Tiene algún objeto de apego?', cicles: [maternal])
    categoryPlay.questions.create!(text: '¿Qué lugares frecuenta/conoce? (plaza, casa de algún familiar/playa/patio/campo, etc.)', cicles: [maternal])

    #ILLNESS
    categoryIllness.questions.create!(text: 'Escarlatina', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: 'Sarampión', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: 'Varicela', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: 'Rubeola', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: 'Paperas', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: 'Tos convulsa', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: '¿Tuvo o tiene enfermedades importantes? ¿Cuáles?', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: '¿Sufre enfermedades crónicas? ¿Cuáles?', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: '¿Toma medicamentos regularmente? ¿Cuáles?', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: '¿Existen consecuencias de accidentes? ¿Cuáles?', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: 'Alergias o intolerancia a algún alimento:', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: 'Otra información importante:', cicles: [maternal, primary, secondary])
    categoryIllness.questions.create!(text: 'Comentarios Director', cicles: [maternal, primary, secondary])

    #INTERCONSULTING
    categoryInterconsulting.questions.create!(text: 'Foniatra', cicles: [maternal, primary, secondary])
    categoryInterconsulting.questions.create!(text: 'Psicomotricista', cicles: [maternal, primary, secondary])
    categoryInterconsulting.questions.create!(text: 'Psicopedagogo', cicles: [maternal, primary, secondary])
    categoryInterconsulting.questions.create!(text: 'Psicólogo', cicles: [maternal, primary, secondary])
    categoryInterconsulting.questions.create!(text: 'Psiquiatra', cicles: [maternal, primary, secondary])
    categoryInterconsulting.questions.create!(text: 'Neuropediatra', cicles: [maternal, primary, secondary])
    categoryInterconsulting.questions.create!(text: '¿Desea realizar algún comentario al respecto?', cicles: [maternal, primary, secondary])
    categoryInterconsulting.questions.create!(text: 'Comentarios Director', cicles: [maternal, primary, secondary])
    categoryInterconsulting.questions.create!(text: 'Adjuntar informes', cicles: [maternal, primary, secondary])

    #OBSEVARTIONS
    categoryObservation.questions.create!(text: 'Respecto a los cuidados diarios ¿quién se ocupa de qué? ¿baño? ¿sueño?', cicles: [maternal])
    categoryObservation.questions.create!(text: 'Relación con otros miembros de la familia', cicles: [maternal])
    categoryObservation.questions.create!(text: 'Preocupaciones entorno a la crianza y el desarrollo de su hijo/a', cicles: [maternal, primary, secondary])
    categoryObservation.questions.create!(text: 'Aspectos importantes que debemos considerar', cicles: [maternal, primary, secondary])
    categoryObservation.questions.create!(text: 'Lenguaje y comunicación', cicles: [maternal, primary, secondary])
    categoryObservation.questions.create!(text: '¿Qué le gusta hacer?', cicles: [primary, secondary])
    categoryObservation.questions.create!(text: '¿Qué talento presenta?', cicles: [primary, secondary])
    categoryObservation.questions.create!(text: '¿Cómo define a su hijo? Mi hijo/a es…', cicles: [maternal, primary, secondary])

    #EDUCATION PROYECT
    categoryEducationProyect.questions.create!(text: '¿Cómo llegó a conocer nuestra institución?', cicles: [maternal, primary, secondary])
    categoryEducationProyect.questions.create!(text: '¿Qué conocimientos, habilidades y/o actutydes fundamentales cree que deben desarrollarse en el proceso de aprendizaje de su hijo/a para lograr un  alto desempeño en la complejidad y desafíos del mundo actual?', cicles: [maternal, primary, secondary])
    categoryEducationProyect.questions.create!(text: '¿Por qué considera importante una propuesta bilingüe en la formación de su hijo/a?', cicles: [maternal, primary, secondary])
    categoryEducationProyect.questions.create!(text: 'Detalle aquí otra información que crea importante y que pueda contribuir a una atención eficiente e integral del alumno/a:', cicles: [maternal, primary, secondary])
    categoryEducationProyect.questions.create!(text: '¿Qué expectativa pedagógica, vincular, etc, tiene la familia respecto a la Institución Educativa?', cicles: [maternal, primary, secondary])
    categoryEducationProyect.questions.create!(text: '¿Qué no puede faltar en el vínculo con la Institución?', cicles: [primary])
    categoryEducationProyect.questions.create!(text: '¿Qué opina de los grupos de WhatsApp de padres?', cicles: [primary])
    categoryEducationProyect.questions.create!(text: '¿Qué expectativa pedagógica, vincular, etc, tiene la familia respecto a la Institución Educativa?', cicles: [secondary])
    
    #AUTHORIZATION IMAGE
    categoryAuthorizationImage.questions.create!(text: '¿Autoriza imagen?', cicles: [maternal, primary, secondary])
    categoryAuthorizationImage.questions.create!(text: 'Adjuntar documento firmado', cicles: [maternal, primary, secondary])

end
