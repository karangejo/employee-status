defmodule EmployeeStatusWeb.Schema do
  use Absinthe.Schema


  object :employee do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :status, non_null(:string)
  end

  alias EmployeeStatusWeb.EmployeeResolver

  query do
    @desc "Get all employees"
    field :all_employees, non_null(list_of(non_null(:employee))) do
      resolve(&EmployeeResolver.all_employees/3)
    end
  end

  mutation do

    @desc "Create a new employee"
    field :create_employee, :employee do
      arg :name, non_null(:string)
      arg :status, non_null(:string)

      resolve &EmployeeResolver.create_employee/3
    end

    @desc "Delete an employee"
    field :delete_employee, :employee do
      arg :id, non_null(:id)

      resolve &EmployeeResolver.delete_employee/3
    end

    @desc "Update an employee status"
    field :update_employee_status, :employee do
      arg :id, non_null(:id)
      arg :status, non_null(:string)

      resolve &EmployeeResolver.update_employee_status/3
    end
  end

  subscription do
    @desc "Subscribe to any employee status change"
    field :updated_any_employee_status, :employee do
      config fn _, _ ->
       {:ok, topic: :any_employee_updated}
      end
      trigger :update_employee_status, topic: fn _ ->
        :any_employee_updated
      end
    end
  end
end
