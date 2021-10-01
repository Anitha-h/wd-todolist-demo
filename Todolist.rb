require "date"
date = Date.today

class Todo
  def initialize(assignment, date, completed)
    @assignment = assignment
    @date = date
    @completed = completed
  end

  def assignment
    @assignment
  end

  def Date
    @date
  end

  def completed
    @completed
  end

  def to_displayable_string
    display_status = "[ ]"
    text = @assignment
    display_date = @date
    if ((@date < Date.today) || (@date > Date.today))
      return "#{display_status} #{text}  #{display_date}"
    elsif ((@date == Date.today) && (@completed == false))
      return "#{display_status} #{text}"
    else
      display_status = "[X]"
      return "#{display_status} #{text}"
    end
  end

  def overdue?
    @date < Date.today
  end

  def due_today?
    @date == Date.today
  end

  def due_later?
    @date > Date.today
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def add(new_list)
    @todos.push(new_list)
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  def to_displayable_list
    @todos.map { |num| num.to_displayable_string }
  end
end

todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]
todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}
todos_list = TodosList.new(todos)
todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
