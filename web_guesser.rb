require 'sinatra'

SECRET_NUMBER = rand(101)

def check_guess(guess)
  return "correct!" if correct? guess
  return "way too high!" if way_too_high? guess
  return "too high" if too_high? guess
  return "way too low!" if way_too_low? guess
  return "too low" if too_low? guess
end

def correct?(guess)
  guess == SECRET_NUMBER
end

def too_high?(guess)
  guess > SECRET_NUMBER
end

def way_too_high?(guess)
  guess > SECRET_NUMBER + 5
end

def too_low?(guess)
  guess < SECRET_NUMBER
end

def way_too_low?(guess)
  guess < SECRET_NUMBER - 5
end

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end
