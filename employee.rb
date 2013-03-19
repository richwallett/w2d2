class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary)
    @name, @title, @salary = name, title, salary
  end

  def boss=(boss)
    @boss = boss
  end

  def calculate_bonus(multiplier)
    @salary * multiplier
  end


end

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary)
    super(name, title, salary)
    @employees = []
  end

  def assign_new_employee(new_employee)
    unless @employees.include?(new_employee)
      @employees << new_employee
      new_employee.boss = self
    end
  end

  def calculate_bonus(multiplier)
    queue = [] + @employees
    total_salary = 0
    until queue.empty?
      employee = queue.pop
      queue += employee.employees if employee.class == Manager
      total_salary += employee.salary
    end
    total_salary
  end

end

dylan = Manager.new("Dylan", "Manager", 250000)
rich = Manager.new("Rich", "Cleaning Crew", 100000)
joe = Employee.new("Joe", "Designer", 70000)
dylan.assign_new_employee(rich)
rich.assign_new_employee(joe)
p dylan.calculate_bonus(1)
p dylan.calculate_bonus(1)