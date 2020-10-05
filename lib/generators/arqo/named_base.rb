# frozen_string_literal: true

require 'rails/generators/named_base'

module ARQO
  module Generators
    class NamedBase < Rails::Generators::NamedBase
      argument :attributes, type: :array, default: [], banner: 'associated_relation[:class_name]'

      private

      def associated_relation
        attributes.find { |attribute| attribute.name == 'associated_relation' }&.type
      end

      def associated_relation_class
        associated_relation&.to_s&.classify
      end

      def factory
        (associated_to || class_name)&.to_s&.underscore
      end
    end
  end
end
