defmodule EmployeeStatusWeb.EmployeeResolver do
  alias EmployeeStatus.Staff

  def all_employees(_root, _args, _info) do
    {:ok, Staff.list_employees()}
  end

  def create_employee(_root, args, _info) do
    case Staff.create_employee(args) do
      {:ok, employee} ->
        {:ok, employee}
      _error ->
        {:error, "could not create employee"}
    end
  end

  def delete_employee(_root, %{id: id}, _info) do
    employee = Staff.get_employee!(id)
    case Staff.delete_employee(employee) do
      {:ok, employee} ->
        {:ok, employee}
      _error ->
        {:error, "could not delete employee"}
    end
  end

  def update_employee_status(_root, %{id: id, status: status}, _info) do
    employee = Staff.get_employee!(id)
    case Staff.update_employee(employee,%{status: status}) do
      {:ok, employee} ->
        {:ok, employee}
      _error ->
        {:error, "could not create employee"}
    end
  end

end
