# frozen_string_literal: true

require 'rails/railtie'

module ARQO
  class Railtie < Rails::Railtie
    generators do |app|
      Rails::Generators.configure! app.config.generators
      require_relative '../generators/model_generator'
    end
  end
end
