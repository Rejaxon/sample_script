# 指定方法
#   validates :field_name, datetime: { foramt: "%Y/%m/%d %H:%M", message: "error message" }
#
class DatetimeValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    raw_val = record.read_attribute_before_type_cast(:attribute)
    return if raw_val.blank?
    
    if options[:format]
      DateTime.strptime(raw_val, format)
    else
      DateTime.parse(raw_val)
    end
    rescue
      record.errors.add(attribute, options[:message] || :datetime)
  end
end






