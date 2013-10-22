class GamesController < ApplicationController
  
  before_filter :load_player_names, only: [:new, :edit]
  
  def index
    
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
    3.times { @game.players.build }
  end

  def create
    @game = Game.new(game_params)
    
    if @game.save
      redirect_to @game
    else
      render :new
    end
  end

  def destroy
    @game = Game.find(params[:id])
    if @game.destroy
      flash[:notice] = "Game #{@game.title} deleted!"
    else
      flash[:error] = "Game #{@game.title} undelete!"
    end
    
    redirect_to :games
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    
    if @game.save
      redirect_to @game
    else
      render :edit
    end
  end
  
  def score
    @game = Game.find(params[:id])
    players = params[:players]
    
    players.each do |id, points|
      player = Player.find(id)
      player.score += points.to_i
      player.save
    end
    
    redirect_to @game
  end
  
  private
  def game_params
    params.require(:game).permit(:title, players_attributes: [:id, :name, :_destroy])
  end
  
  def load_player_names
    @player_names = Player.all.map { |p| p.name }.uniq
  end
end
