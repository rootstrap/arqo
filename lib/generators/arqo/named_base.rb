# frozen_string_literal: true

require 'rails/generators/named_base'

module ARQO
  module Generators
    class NamedBase < Rails::Generators::NamedBase
      class_option :associated_relation, type: :string, default: nil

      private

      def associated_relation
        @associated_relation ||= options['associated_relation']
      end

      def associated_relation_class
        associated_relation&.to_s&.classify
      end
    end
  end
end
