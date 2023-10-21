# frozen_strin_literal: true

require_relative '../lib/main.rb'

describe GameState do
  describe "#place_sign" do
    subject(:game) { described_class.new }
    it "places string into given space on board" do
      game.place_sign(0, 'x')
      expect(game.board[0]).to eq('x')
    end
  end
end
