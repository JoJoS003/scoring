class Player < ActiveRecord::Base
  belongs_to :game
  
  validates :name, presence: true
  validates :score, numericality: { only_integer: true }
end
