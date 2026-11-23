# Elixir sample: module, pattern matching, pipe, GenServer
defmodule Shop.Order do
  @moduledoc """
  Sample module for orders.
  """
  use GenServer
  require Logger

  @tax_rate 0.11
  @statuses [:pending, :paid, :shipped]

  defstruct id: nil, items: [], status: :pending

  @type t :: %__MODULE__{id: integer(), items: list(), status: atom()}

  ## API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @spec total(t()) :: float()
  def total(%__MODULE__{items: items}) do
    items
    |> Enum.map(fn %{price: price, qty: qty} -> price * qty end)
    |> Enum.sum()
    |> Kernel.*(1 + @tax_rate)
  end

  def label(%__MODULE__{status: :paid} = order), do: "Paid: #{total(order)}"
  def label(%__MODULE__{status: :shipped}), do: "Shipped"
  def label(%__MODULE__{items: []}), do: "Empty"
  def label(_other), do: "Pending"

  ## Callbacks
  @impl true
  def init(opts) do
    Logger.info("Starting with #{inspect(opts)}")
    {:ok, %{orders: %{}, count: 0}}
  end

  @impl true
  def handle_call({:add, order}, _from, state) do
    case Map.fetch(state.orders, order.id) do
      {:ok, _existing} -> {:reply, {:error, :exists}, state}
      :error -> {:reply, :ok, put_in(state, [:orders, order.id], order)}
    end
  end
end

order = %Shop.Order{id: 1, items: [%{price: 12.5, qty: 3}], status: :paid}
IO.puts(Shop.Order.label(order))
