# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/rails/model/model_generator'
require_relative 'rails/query_generator'

module Rails
  module Generators
    class ModelGenerator
      hook_for :query, type: :boolean, default: false
    end
  end
end
