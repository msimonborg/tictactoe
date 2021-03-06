defmodule TicTacToe.Game.Server do
  @moduledoc """
  Game server.
  """

  use GenServer, restart: :temporary  

  alias TicTacToe.Game.Board
  alias TicTacToe.Game

  @doc """
  Starts the server and initializes the game board as the server state.
  """
  def init(:ok), do: Game.start_board

  def handle_call(:board, _from, board), do: {:reply, board, board}
  def handle_call({:move, position, value}, _from, board) do
    case Board.put(board, position, value) do
      :ok ->
        {:reply, Board.current_state(board), board}
      any ->
        {:reply, any, board}
    end
  end
end
