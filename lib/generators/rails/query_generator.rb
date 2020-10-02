# frozen_string_literal: true

require_relative '../arqo/named_base'

module Rails
  module Generators
    class QueryGenerator < ARQO::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      check_class_collision suffix: 'Query'

      hook_for :test_framework

      def create_model_query
        return if class_name.blank?

        template_file = File.join('app/queries', class_path, "#{file_name}_query.rb")
        template 'query.rb.erb', template_file
      end
    end
  end
end
