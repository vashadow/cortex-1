class TreeFieldType < FieldType
  VALIDATION_TYPES = {
    presence: :valid_presence_validation?
  }.freeze

  attr_accessor :data, :values
  attr_reader :validations, :metadata

  validates :values, presence: true, if: :validate_presence?
  validate :value_is_allowed?

  def validations=(validations_hash)
    @validations = validations_hash.deep_symbolize_keys
  end

  def data=(data_hash)
    @values = data_hash.deep_symbolize_keys[:values]
  end

  def metadata=(metadata_hash)
    @metadata = metadata_hash.deep_symbolize_keys
  end

  def acceptable_validations?
    valid_types? && valid_options?
  end

  private

  def value_is_allowed?
    @values.each do |value|
      if Tree.gather_ids(@metadata[:allowed_values]).include?(value)
        true
      else
        errors.add(:value, "must be allowed.")
        false
      end
    end
  end

  def valid_types?
    validations.all? do |type, options|
      VALIDATION_TYPES.include?(type)
    end
  end

  def valid_options?
    validations.all? do |type, options|
      self.send(VALIDATION_TYPES[type])
    end
  end

  def valid_presence_validation?
    @validations.key? :presence
  end

  def validate_presence?
    @validations.key? :presence
  end

end