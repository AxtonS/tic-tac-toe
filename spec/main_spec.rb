# frozen_strin_literal: true

require '../lib/main.rb'

describe GameState do
  subject(:game) { described_class.new }

  describe '#victory_condition' do

    it 'return true when top row is same sign' do
      game.board = ['X', 'X', 'X', ' ', ' ', ' ', ' ', ' ', ' ']
      expect(game.victory_condition('X')).to eq(true)
    end

    it 'return nil when sign has not won' do
      game.board = ['X', 'X', 'X', ' ', ' ', ' ', ' ', ' ', ' ']
      expect(game.victory_condition('O')).to be_nil
    end
  end

  describe '#place_sign' do

    it 'places the correct sign in correct space' do
      space = 0
      sign = 't'
      game.place_sign(space, sign)
      expect(game.board[space]).to eq(sign)
    end
  end
end
