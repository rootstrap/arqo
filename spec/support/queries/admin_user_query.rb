# frozen_string_literal: true

class AdminUserQuery < ARQO::Query
  module Scope
    def with_known_birthday
      where.not(birthday: nil)
    end
  end

  private

  def associated_relation
    users = User.arel_table
    User.where(users[:email].matches('%@admin.com'))
  end
end
