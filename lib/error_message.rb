class ErrorMessage
  attr_reader :key, :description

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

    def build_not_unique(error)
      key = error.message.scan(/index_\S+/)[0].gsub("\"","") + ".not_unique"
      key.gsub("\"","")
      description = I18n.t(key)

      new('not_unique', description)
    end

    def build_record_invalid(error)
      record = error.record

      new('record_invalid', record.errors)
    end

    def build_invalid_credentials
      new('invalid_credentials', I18n.t('errors.invalid_credentials'))
    end

    def build_required_signed_in
      new('forbidden.required_signed_in', I18n.t('errors.forbidden.required_signed_in'))
    end

    def build_required_not_signed_in
      new('forbidden.required_not_signed_in', I18n.t('errors.forbidden.required_not_signed_in'))
    end

    def build_invalid_token
      new('forbidden.invalid_token', I18n.t('forbidden.invalid_token'))
    end

  end

  def initialize(key, description)
    @key = key
    @description = description
  end
end
