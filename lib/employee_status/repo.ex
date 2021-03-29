defmodule EmployeeStatus.Repo do
  use Ecto.Repo,
    otp_app: :employee_status,
    adapter: Ecto.Adapters.Postgres
end
