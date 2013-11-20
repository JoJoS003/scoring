# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

player_form_block = ->
  timestamp = new Date().getTime()
  """
  <div class="form-group">
        <label for="game_players_attributes_#{timestamp}_name">Name</label>
        <input class="form-control" id="game_players_attributes_#{timestamp}_name" name="game[players_attributes][#{timestamp}][name]" placeholder="player's name" type="text" autocomplete="off" list="list_player_names">
      </div>
  """

$(".add-more-player").click(->
  $(this).before(player_form_block())
)

$(".score-input").click(->
  $(this).select()
)
