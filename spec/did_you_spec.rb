require 'did_you'

RSpec.describe DidYou::Spell do
  describe '#check' do
    subject { ->(word, dictionary) { described_class.check(word, dictionary) } }

    its(['rais', %w[raise]]) { is_expected.to eq %w[raise] }
    its(['raise', %w[raise]]) { is_expected.to eq [] }
  end
end
