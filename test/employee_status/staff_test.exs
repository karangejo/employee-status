defmodule EmployeeStatus.StaffTest do
  use EmployeeStatus.DataCase

  alias EmployeeStatus.Staff

  describe "employees" do
    alias EmployeeStatus.Staff.Employee

    @valid_attrs %{name: "some name", status: "some status"}
    @update_attrs %{name: "some updated name", status: "some updated status"}
    @invalid_attrs %{name: nil, status: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Staff.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Staff.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Staff.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Staff.create_employee(@valid_attrs)
      assert employee.name == "some name"
      assert employee.status == "some status"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Staff.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = Staff.update_employee(employee, @update_attrs)
      assert employee.name == "some updated name"
      assert employee.status == "some updated status"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Staff.update_employee(employee, @invalid_attrs)
      assert employee == Staff.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Staff.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Staff.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Staff.change_employee(employee)
    end
  end
end
