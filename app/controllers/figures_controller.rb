class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all

    erb :'figures/index'
  end

  get '/figures/new' do
    erb :"/figures/new"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])

    erb :'/figures/edit'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])

    erb :'/figures/show'
  end

  post '/figures' do
    figure = Figure.create(name: params[:figure][:name])

    params[:figure][:title_ids].each do |title_id|
      figure.titles << Title.find(title_id) if title_id != ""
    end unless params[:figure][:title_ids] == nil

    params[:figure][:landmark_ids].each do |landmark_id|
      figure.landmarks << Landmark.find(landmark_id) if landmark_id != ""
    end unless params[:figure][:landmark_ids] == nil

    if params[:figure][:new_title] != ""
      title = Title.create(:name => params[:figure][:new_title])
      figure.titles << title
    end

    if params[:figure][:new_landmark] != ""
      landmark = Landmark.create(:name => params[:figure][:new_landmark])
      figure.landmarks << landmark
    end

    redirect '/figures'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(:name => params[:figure][:name])
    @landmark = Landmark.create(:name => params[:figure][:landmark_name])
    @figure.landmarks << @landmark

    redirect "/figures/#{@figure.id}"
  end
end
