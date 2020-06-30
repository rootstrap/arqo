# frozen_string_literal: true

module ARQO
  # Parent class for query objects
  class Query
    attr_reader :relation
    delegate_missing_to :relation

    def initialize(relation = associated_relation)
      @relation = relation.extending(scope_module)
    end

    private

    # Returns the model to which the query object is associated.
    # By default it will infer the name from the query object's class
    # assuming the name is the name of the model with "Query" as the suffix.
    #
    # As an example, UserQuery would be associated with the User model and
    # Blog::PostQuery would be associated with the Blog::Post namespaced model.
    #
    # This method can be overridden to bypass this convention and associate
    # the query object to another relation by returning it.
    #
    # ==== Example
    #     class PostQuery < ARQO::Query
    #       # ...
    #
    #       private
    #
    #       def associated_relation
    #         Blog::Post
    #       end
    #     end
    #
    # @return [Class, ActiveRecord::Relation]
    def associated_relation
      class_name = self.class.name
      derived_relation_name = class_name.sub(/Query$/, '')

      unless Object.const_defined?(derived_relation_name)
        raise NameError, "Could not find model #{derived_relation_name} associated " \
          "to query #{class_name}.\n Make sure the name is correct or override " \
          '#associated_relation to provide a custom model'
      end

      derived_relation_name.constantize.all
    end

    def scope_module
      "#{self.class}::Scope".constantize
    end
  end
end
