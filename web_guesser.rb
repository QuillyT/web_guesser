require 'sinatra'

number = rand(101).to_s

get '/' do
  erb :index, :locals => {:number => number}
end
