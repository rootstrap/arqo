# frozen_string_literal: true

require 'generators/model_generator'

RSpec.describe Rails::Generators::ModelGenerator do
  destination File.expand_path('tmp', __dir__)

  before { prepare_destination }
  after(:all) { FileUtils.rm_rf destination_root }

  describe 'the generated query object' do
    subject { file('app/queries/your_model_query.rb') }

    describe 'naming' do
      before { run_generator %w[YourModel --query=true] }

      it 'creates a file with the right name' do
        expect(subject).to exist
      end

      it 'creates a class with the right name' do
        expect(subject).to contain 'class YourModelQuery'
      end
    end
  end

  describe 'the generated query object spec' do
    context 'with rspec as test_framework' do
      describe 'naming' do
        subject { file('spec/queries/your_model_query_spec.rb') }

        before { run_generator %w[YourModel --query=true -t=rspec] }

        it 'creates a spec file with the right name' do
          expect(subject).to exist
        end

        it 'creates a spec class with the right name' do
          expect(subject).to contain 'describe YourModelQuery'
        end
      end
    end
  end
end
