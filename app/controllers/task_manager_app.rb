require_relative "../models/task"

class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get "/" do
    erb :dashboard
  end

  get "/tasks" do
    @tasks = []
    erb :index
  end

  get "/tasks/new" do
    erb :new
  end

  post "/tasks" do
    task = Task.new(params[:task]
    task.save
    redirect '/tasks'
  end

end