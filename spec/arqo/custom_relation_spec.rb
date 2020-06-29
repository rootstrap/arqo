# frozen_string_literal: true

RSpec.describe 'Custom relation' do
  context 'with a valid model class' do
    before do
      3.times do |i|
        CustomPost.create(title: "Post #{i}")
      end

      2.times do
        CustomPost.create(title: nil)
      end
    end

    describe '#new' do
      it 'queries the specified model' do
        expect(PostQuery.new.count).to eq(5)
      end
    end

    describe 'query object defined methods' do
      it 'applies all the scopes' do
        expect(PostQuery.new.without_title.count).to eq(2)
      end
    end
  end

  context 'with an ActiveRecord::Relation' do
    before do
      3.times do |i|
        User.create(email: "john-#{i}@admin.com",
                    name: "example-admin-#{i}",
                    birthday: 50.years.ago)
      end

      2.times do |i|
        User.create(email: "john-#{i}@admin.com", name: "example-admin-#{i}", birthday: nil)
      end

      User.create(email: 'john-foo@example.com', name: 'John Foo', birthday: 20.years.ago)
      User.create(email: 'john-bar@example.com', name: 'John Bar', birthday: nil)
    end

    describe '#new' do
      it 'maintains the relation to query' do
        expect(AdminUserQuery.new.count).to eq(5)
      end
    end

    describe 'query object defined methods' do
      it 'applies all the scopes' do
        expect(AdminUserQuery.new.with_known_birthday.count).to eq(3)
      end
    end
  end
end
