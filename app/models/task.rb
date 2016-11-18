require 'sqlite3'

class Task

  def initialize(task_params)
    @title       = task_params["title"]  
    @description = task_params["description"]  
  end

end