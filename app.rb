require 'sinatra'
require 'slim'
require './converter'

get '/' do
  slim :index, locals: {source_csv: nil, target_csv: nil}
end

post '/convert' do
  source_csv = params[:source_csv]
  begin
    target_csv = Converter.call(source_csv)
  rescue Exception => e
    target_csv = e.message
  end
  slim :index, locals: {source_csv: source_csv, target_csv: target_csv}
end
