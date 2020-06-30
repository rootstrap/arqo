# frozen_string_literal: true

RSpec.describe 'Unknown model' do
  before do
    3.times do |i|
      User.create(email: "user-#{i}@example.com", name: "example-user-#{i}", birthday: 50.years.ago)
    end
    3.times do |i|
      User.create(email: "test-user-#{i}@example.com", name: "user-#{i}", birthday: 20.years.ago)
    end
    3.times do |i|
      User.create(email: "other-user-#{i}@example.com", name: "other-user-#{i}")
    end
    3.times do |i|
      User.create(email: "lvh-user-#{i}@lvh.me", name: "lvh-user-#{i}", birthday: 30.years.ago)
    end
  end

  describe '#new' do
    context 'when initialized with an ActiveRecord::Relation' do
      it 'maintains the previously applied scopes' do
        query = ForUserQuery.new(User.where.not(birthday: nil))
        expect(query.all.count).to eq(9)
      end
    end

    context 'when the relation is derived' do
      it 'throws an error since the model does not exist' do
        expect { ForUserQuery.new }.to raise_error(NameError, /Could not find model ForUser/)
      end
    end
  end

  describe 'query object defined methods' do
    context 'when calling one of them' do
      it 'applies the scope' do
        expect(ForUserQuery.new(User.all).with_known_birthday.count).to eq(9)
      end
    end

    context 'when chaining two of them' do
      it 'applies all the scopes' do
        expect(ForUserQuery.new(User.all).with_known_birthday.with_example_domain.count).to eq(6)
      end
    end

    context 'when chiaining them with ActiveRecord::Relation methods' do
      it 'applies all the scopes' do
        expect(ForUserQuery.new(User.all)
                 .with_known_birthday
                 .where('birthday > ?', 25.years.ago)
                 .with_example_domain
                 .count).to eq(3)
      end
    end
  end
end
