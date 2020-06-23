# frozen_string_literal: true

class User < ActiveRecord::Base
  validates :name, presence: true
end
