# frozen_string_literal: true

require 'generators/rails/query_generator'

RSpec.describe Rails::Generators::QueryGenerator do
  destination File.expand_path('tmp', __dir__)

  before { prepare_destination }
  after(:all) { FileUtils.rm_rf destination_root }

  describe 'the generated query object' do
    subject { file('app/queries/your_model_query.rb') }

    describe 'naming' do
      before { run_generator %w[YourModel] }

      it 'creates a file with the right name' do
        expect(subject).to exist
      end

      it 'creates a class with the right name' do
        expect(subject).to contain 'class YourModelQuery'
      end
    end

    describe 'namespacing' do
      subject { file('app/queries/your_namespace/your_model_query.rb') }

      before { run_generator %w[YourNamespace::YourModel] }

      it 'creates a file with the right name adn location' do
        expect(subject).to exist
      end

      it 'creates a class with the right name' do
        expect(subject).to contain 'class YourNamespace::YourModelQuery'
      end
    end

    describe 'inheritance' do
      before { run_generator %w[YourModel] }

      it 'creates a class inheriting from ARQO::Query' do
        expect(subject).to contain 'class YourModelQuery < ARQO::Query'
      end
    end

    describe 'contents' do
      context 'by default' do
        before { run_generator %w[YourModel] }

        it 'creates a module named Scope' do
          expect(subject).to contain 'module Scope'
        end
      end

      context 'with associated_to attribute' do
        context 'when attribute type is CamelCased value' do
          before { run_generator %w[YourModel associated_to:MainModel] }

          it 'creates a method named associated_relation' do
            expect(subject).to have_method(:associated_relation).containing('MainModel')
          end
        end

        context 'when attribute type is snake_cased value' do
          before { run_generator %w[YourModel associated_to:main_model] }

          it 'creates a method named associated_relation' do
            expect(subject).to have_method(:associated_relation).containing('MainModel')
          end
        end
      end
    end
  end

  describe 'the generated query object spec' do
    context 'with rspec as test_framework' do
      describe 'naming' do
        subject { file('spec/queries/your_model_query_spec.rb') }

        before { run_generator %w[YourModel -t=rspec] }

        it 'creates a spec file with the right name' do
          expect(subject).to exist
        end

        it 'creates a spec class with the right name' do
          expect(subject).to contain 'describe YourModelQuery'
        end
      end

      describe 'namespacing' do
        subject { file('spec/queries/your_namespace/your_model_query_spec.rb') }

        before { run_generator %w[YourNamespace::YourModel -t=rspec] }

        it 'creates a spec file with the right name adn location' do
          expect(subject).to exist
        end

        it 'creates a spec class with the right name' do
          expect(subject).to contain 'describe YourNamespace::YourModelQuery'
        end
      end
    end
  end
end
