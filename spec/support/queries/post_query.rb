# frozen_string_literal: true

class PostQuery < ARQO::Query
  module Scope
    def without_title
      where(title: nil)
    end
  end

  private

  def associated_relation
    CustomPost
  end
end
