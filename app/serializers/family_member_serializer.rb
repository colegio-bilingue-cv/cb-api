class FamilyMemberSerializer < Panko::Serializer
  attributes :id, :ci, :role, :full_name, :birthdate, :birthplace, :nationality,
    :first_language, :marital_status, :cellphone, :email,
    :address, :neighborhood, :education_level, :occupation, :workplace,
    :workplace_neighbourhood, :workplace_phone, :workplace_address, :edited_family_member_message

    def edited_family_member_message
      p context
      p 'antes del object new record'
      unless context[:new_record]
        p 'despues del object new record'
        edited_family_member_message = I18n.t('family_member.edited')
      end
    end
end
