class Employee
  attr_reader :title, :salary, :boss, :name

  def initialize(title, salary, name, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @boss.employees << self unless boss.nil?
  end

  def bonus(multiplier)
    bonus = @salary * multiplier
  end

end

class Manager < Employee
  attr_reader :employees

  def initialize(title, salary, name, boss = nil)
    super
    @employees = []
  end

  def bonus(multiplier)
    return multiplier * (add_salaries - salary) unless employees.empty?
    multiplier * add_salaries
  end

  def add_salaries
    return salary if employees.empty?
    sum = 0
    @employees.each { |employee| sum += employee.add_salaries }
    sum + salary
  end

end

ned = Manager.new("f",1000000,"ned")
darren = Manager.new("TM",78000,"Darren",ned)
shawna = Manager.new("TA",12000,"Shawna", darren)
david = Manager.new("TA", 10000, "David", darren)
p ned.bonus(5) # => 500_000
p darren.bonus(4) # => 88_000
p david.bonus(3)
