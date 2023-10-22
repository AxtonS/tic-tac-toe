# frozen_string_literal: true

require_relative '../lib/main'

describe GameState do
  describe '#place_sign' do
    subject(:game) { described_class.new }
    it 'places string into given space on board' do
      game.place_sign(0, 'x')
      expect(game.board[0]).to eq('x')
    end

    it 'returns nil if given an invalid space' do
      game.place_sign(9, 'x')
      expect(game.board[9]).to be_nil
    end
  end

  describe '#victory_condition' do
    subject(:game) { described_class.new }
    it 'returns true if top row is same sign' do
      game.instance_variable_set(:@board, ['x', 'x', 'x', ' ', ' ', ' ', ' ', ' ', ' '])
      expect(game.victory_condition('x')).to eql true
    end

    it 'returns true if middle row is same sign' do
      game.instance_variable_set(:@board, [' ', ' ', ' ', 'a', 'a', 'a', ' ', ' ', ' '])
      expect(game.victory_condition('a')).to eql true
    end

    it 'returns true if bottom row is same sign' do
      game.instance_variable_set(:@board, [' ', ' ', ' ', ' ', ' ', ' ', 'z', 'z', 'z'])
      expect(game.victory_condition('z')).to eql true
    end

    it 'returns true if forward diagonal is same sign' do
      game.instance_variable_set(:@board, [' ', ' ', 'y', ' ', 'y', ' ', 'y', ' ', ' '])
      expect(game.victory_condition('y')).to eql true
    end

    it 'returns true if backward diagonal is same sign' do
      game.instance_variable_set(:@board, ['G', ' ', ' ', ' ', 'G', ' ', ' ', ' ', 'G'])
      expect(game.victory_condition('G')).to eql true
    end

    it 'returns nil if no winner' do
      expect(game.victory_condition('x')).to be_nil
    end
  end
end

describe Player do
  describe '#input' do
    subject(:player) { described_class.new }
    it 'changes selection to 0 when user inputs q' do
      player.input('q')
      selection = player.instance_variable_get(:@selection)
      expect(selection).to eql(0)
    end

    it 'changes selection to 8 when user inputs br' do
      player.input('br')
      selection = player.instance_variable_get(:@selection)
      expect(selection).to eql(8)
    end
  end

  describe '#valid_input' do
    subject(:player) { described_class.new }
    it 'returns the input when valid' do
      allow(player).to receive(:gets).and_return('w')
      expect(player.valid_input).to eql('w')
    end

    it 'prompts for valid input when given invalid input' do
      allow(player).to receive(:gets).and_return('m', 'q')
      error = 'Please enter a valid input:'
      expect(player).to receive(:puts).with(error)
      player.valid_input
    end

    it 'prompts for valid input 10 times when given 10 invalid inputs' do
      allow(player).to receive(:gets).and_return('l', 'm', 'n', 'o', 'p', '1', '2', '3', '4', '5', 'tl')
      error = 'Please enter a valid input:'
      expect(player).to receive(:puts).with(error).exactly(10).times
      player.valid_input
    end
  end
end
