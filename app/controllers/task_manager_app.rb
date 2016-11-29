require_relative '../models/task'

class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path('..', __dir__)
  set :method_override, true

  get '/' do
    erb :dashboard
  end

  get '/tasks' do
    @tasks = Task.all
    erb :index
  end

  get '/tasks/new' do
    erb :new
  end

  post '/tasks' do
    task = Task.new(params[:task])
    task.save
    redirect '/tasks'
  end

  get '/tasks/:id' do # could we use a block var here?
    @task = Task.find(params[:id])
    erb :show
  end

  get '/tasks/:id/edit' do
    @task = Task.find(params[:id])
    erb :edit
  end

  put '/tasks/:id' do |id|
    Task.update(id.to_i, params[:task])
    redirect "/tasks/#{id}"
  end

  delete '/tasks/:id' do |id| # why the block vars on these last two?
    Task.destroy(id.to_i)
    redirect '/tasks'
  end


end