defmodule NeuralNetwork.Connection do
  defstruct source: %{}, target: %{}, weight: 0.4 # make weight random at some point

  def start_link(name) do
    Agent.start_link(fn -> %NeuralNetwork.Connection{} end, name: name)
  end

  def get(name) do
    Agent.get(name, &(&1))
  end

  def update(name, key, value) do
    Agent.update(name, fn connection ->
      Map.put(connection, key, value)
    end)
  end

  def stop(name) do
    Process.exit(Process.whereis(name), :shutdown)
  end

  def connection_for(source, target) do
    NeuralNetwork.Connection.start_link(:conn)
    NeuralNetwork.Connection.update(:conn, :source, source)
    NeuralNetwork.Connection.update(:conn, :target, target)
    NeuralNetwork.Connection.get(:conn)
  end
end