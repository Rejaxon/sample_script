class PhoneNumberValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    return unless value.present?
    unless /\A[0-9]{10,11}\z/ === value.gsub('-', '')
      record.errors.add(attribute, options[:message] || :phone_number)
    end
  end
end






