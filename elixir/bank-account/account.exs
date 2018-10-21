defmodule BankAccount do
  use GenServer

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  def init(:ok) do
    {:ok, %{balance: 0}}
  end

  def handle_call(:get_balance, _from, %{balance: balance} = state) do
    {:reply, balance, state}
  end

  def handle_cast({:update_balance, amount}, %{balance: balance}) do
    {:noreply, %{balance: balance + amount}}
  end

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start_link(__MODULE__, :ok)

    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    call_if_account_opened(account, &(GenServer.call(&1, :get_balance)))
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    call_if_account_opened(account, &(GenServer.cast(&1, {:update_balance, amount})))
  end

  defp call_if_account_opened(account, fun) do
    if Process.alive?(account) do
      fun.(account)
    else
      {:error, :account_closed}
    end
  end
end
