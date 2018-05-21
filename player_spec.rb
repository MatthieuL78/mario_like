require_relative 'player'

describe 'initialization' do
  it 'has to create a new player' do
    player = Player.create()
    expect(player).to be_truthly
  end
end