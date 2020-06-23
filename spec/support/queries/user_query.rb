class UserQuery < ARQO::Query
  module Scope
    def with_example_domain
      where('email LIKE ?', '%@example.com')
    end

    def with_known_birthday
      where.not(birthday: nil)
    end
  end
end
