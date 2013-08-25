class Player

  attr_accessor :opponent, :game

  def initialize()
    self.opponent = nil
  end

  def set_opponent(opponent)
    self.opponent = opponent
  end

end