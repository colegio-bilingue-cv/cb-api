class ErrorMessage
  attr_reader :key, :description

  def initialize(key, description)
    @key = key
    @description = description
  end

  class << self

    def build(klass, type)
      key = "#{klass.name.underscore}.#{type}"
      description = I18n.t(key)

      new(key, description)
    end

    def build_not_found(klass)
      key = "#{klass.underscore}.not_found"
      description = I18n.t(key)

      new(key, description)
    end

    def build_record_invalid(error)
      record = error.record

      new('record_invalid', record.errors)
    end

    def build_invalid_credentials(error)
      new(error.message_key, I18n.t(error.message_key))
    end

    def build_required_signed_in
      new('forbidden.required_signed_in', I18n.t('errors.forbidden.required_signed_in'))
    end

    def build_required_not_signed_in
      new('forbidden.required_not_signed_in', I18n.t('errors.forbidden.required_not_signed_in'))
    end

    def build_invalid_token(error)
      new(error.message_key, I18n.t(error.message_key))
    end

    def build_invalid_student_activation(error)
      new(error.message_key, I18n.t(error.message_key))
    end

  end
end
