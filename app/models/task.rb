require 'sqlite3'

class Task

  attr_reader :title,
              :description,
              :id

  def initialize(task_params)
    @title                    = task_params["title"]  
    @description              = task_params["description"]
    @id                       = task_params["id"] if task_params["id"]
    @database                 = SQLite3::Database.new("db/task_manager_development.db")
    @database.results_as_hash = true
  end

  def save
    @database.execute("INSERT INTO tasks (title, description) VALUES (?, ?);", @title, @description)
  end

  def self.all
    tasks = database.execute("SELECT * FROM tasks")
    tasks.map { |task| Task.new(task) }
  end

  def self.find(id)
    task = database.execute("SELECT * FROM tasks WHERE id = ?;", id).first
    Task.new(task)
  end

  def self.database
    database = SQLite3::Database.new("db/task_manager_development.db")
    database.results_as_hash = true
    database
  end

  def self.update(id, task_params)
    database.execute("UPDATE tasks
                     SET title = ?,
                         description = ?
                     WHERE id = ?;",
                     task_params[:title],
                     task_params[:description],
                     id)
    Task.find(id)
  end

  def self.destroy(id)
    database.execute("DELETE FROM tasks WHERE id = ?;", id)
  end

end

=begin Questions for review
Define CRUD. 
  Create Read Update Delete

Why do we use set method_override: true? 
  This is a workaround HTML forms' inability to handle PUT requests. It turns the POST form into a PUT

Explain the difference between value and name in this line: <input type='text' name='task[title]' value="<%= @task.title %>"/>.
  Value is what displays on the view, the name is how the input will be stored.

What are params? Where do they come from?
  Params are a hash-like string of data provided by the user.

Check out your routes. Why do we need two routes each for creating a new Task and editing an existing Task?
  Edit manipulates an existing SQL id number, new creates a newly incremented id.
  Two HTTP verbs are required. One to update one to show the update.
  1. get the form, 2. post the data.
=end
