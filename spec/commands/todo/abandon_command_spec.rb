require 'app/commands/todo/abandon'

RSpec.describe EventSourceryTodoApp::Commands::Todo::Abandon::Command do
  describe '.build' do
    subject(:build) {
      described_class.build(params)
    }

    context 'without a todo_id' do
      let(:params) {
        {
          abandoned_on: '2017-06-16'
        }
      }
      it 'raises as error' do
        expect { build }.to raise_error(
          EventSourceryTodoApp::BadRequest,
          'todo_id is blank'
        )
      end
    end

    context 'with an invalid abandoned_on date' do
      let(:params) {
        {
          todo_id: SecureRandom.uuid,
          abandoned_on: 'not a date'
        }
      }
      it 'raises as error' do
        expect { build }.to raise_error(
          EventSourceryTodoApp::BadRequest,
          'abandoned_on is invalid'
        )
      end
    end
  end
end
