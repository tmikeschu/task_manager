require_relative "../models/task"

class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get "/" do
    erb :dashboard
  end

  get "/tasks" do
    @tasks = Task.all
    erb :index
  end

  get "tasks/new" do
    
  end

  post "/tasks" do
    
  end

end