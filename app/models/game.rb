class Game < ActiveRecord::Base
  attr_protected

  belongs_to :player1, :class_name => "User"
  belongs_to :player2, :class_name => "User"
  belongs_to :winner,  :class_name => "User"
  belongs_to :loser,  :class_name => "User"

  validates :player1_id, :presence => true
  validates :player2_id, :presence => true

  def name

    result = ""
    if player1
      result = player1.name
    end

    result = result + " vs "
    if player1
      result = result + player2.name
    end

    result
  end

  def winner_name
    if(winner)
      winner.name

    else
      "No Winner"
    end
  end

  def for_user_id user_id
    where("player1 = #{user_id} OR player2 = #{user_id}")
  end

end
