class Game < ActiveRecord::Base
  has_many :players
  accepts_nested_attributes_for :players, allow_destroy: true, 
      reject_if: lambda {|attributes| attributes['name'].blank?}
  
  validates :title, presence: true
  
  def rank_players
    players.sort do |a,b|
      order = b.score <=> a.score
      order = a.name <=> b.name if order == 0
      
      order
    end
  end
  
  def ranks
    rank = {}
    
    last_rank = 1
    last_score = -1
    cursor = 1
    rank_players.each do |p|
      cur_rank = if p.score == last_score
        last_rank
      else
        cursor
      end
      
      rank[p.id] = cur_rank
      
      last_rank = cur_rank
      last_score = p.score
      cursor += 1
    end
    
    rank
  end
  
  def rank(player)
    ranks[player.id]
  end
  
end
