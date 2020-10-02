# frozen_string_literal: true

require_relative '../arqo/named_base'

module Rspec
  module Generators
    class QueryGenerator < ARQO::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)

      def create_model_query_spec
        template_file = File.join('spec/queries', class_path, "#{file_name}_query_spec.rb")
        template 'query_spec.rb.erb', template_file
      end
    end
  end
end
