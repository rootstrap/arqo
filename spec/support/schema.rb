# frozen_string_literal: true

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :custom_posts, force: true do |t|
    t.string :title

    t.timestamps
  end

  create_table :users, force: true do |t|
    t.string :name
    t.string :email, null: false
    t.datetime :birthday

    t.timestamps
  end
end
