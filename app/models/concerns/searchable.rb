module Searchable
  extend ActiveSupport::Concern
  included do
    class_attribute :searchable_attributes, instance_accessor: false, default: [].freeze
  end

  class_methods do
    def searchable_by(*attributes)
      attributes = attributes.flatten.map(&:to_s)

      raise ArgumentError, "At least one searchable attribute is required" if attributes.empty?

      invalid_attributes = attributes - column_names

      if invalid_attributes.any?
        raise ArgumentError, "Unknown searchable attributes: #{invalid_attributes.join(', ')}"
      end

      self.searchable_attributes = attributes.freeze
    end

    def search(query)
      return all if query.blank?

      term = query.to_s.strip
      return all if term.blank?

      pattern = "%#{sanitize_sql_like(query)}%"

      conditions = searchable_attributes.map { |attribute| "#{table_name}.#{attribute} ILIKE :pattern" }.join(" OR ")

      where(conditions, pattern: pattern)
    end
  end
end
