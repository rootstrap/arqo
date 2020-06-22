# frozen_string_literal: true

module ARQO
  # Parent class for query objects
  class Query
    attr_reader :relation
    delegate_missing_to :relation

    def initialize(relation = derived_relation)
      @relation = relation.extending(scope_module)
    end

    private

    def derived_relation_name
      self.class.name.sub(/Query$/, '')
    end

    def derived_relation
      derived_relation_name.constantize.all if Object.const_defined?(derived_relation_name)
    end

    def scope_module
      "#{self.class}::Scope".constantize
    end
  end
end
