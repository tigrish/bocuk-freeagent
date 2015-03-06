require 'sinatra'
require 'slim'

get '/' do
  slim :index, locals: {source_csv: nil, target_csv: nil}
end

post '/convert' do
  source_csv = params[:source_csv]
  slim :index, locals: {source_csv: source_csv, target_csv: 'woohoo'}
end
