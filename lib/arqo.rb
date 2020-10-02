# frozen_string_literal: true

require 'arqo/query'
require 'arqo/version'
require 'arqo/railtie' if defined?(Rails)

module ARQO
  class Error < StandardError; end
  # Your code goes here...
end
