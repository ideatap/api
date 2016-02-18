ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Ideatap.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Ideatap.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Ideatap.Repo)

