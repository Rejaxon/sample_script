
class ModelUtl
  
  # key重複に対応した版。key, valのvalは配列
  def self.group_by(records, &key)
    records.inject({}) do |result, record|
      key = yield(record)
      result[key] ||= []
      result[key] << record
      result
    end
  end
end
