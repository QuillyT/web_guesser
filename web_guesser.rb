require 'sinatra'

@@secret_number = rand(101)
@@count = 5
set :cheat_msg => Proc.new { "The secret number is  #{@@secret_number}" }

def check_guess(guess)
  @@count -= 1
  if @@count == 0
    @@secret_number = rand(101)
    @@count = 5
    return "wrong. Start over!"
  end
  return "correct!"       if correct? guess
  return "way too high!"  if way_too_high? guess
  return "too high!"      if too_high? guess
  return "way too low!"   if way_too_low? guess
  return "too low!"       if too_low? guess
end

def correct?(guess)
  guess == @@secret_number
end

def too_high?(guess)
  guess > @@secret_number
end

def way_too_high?(guess)
  guess > @@secret_number + 5
end

def too_low?(guess)
  guess < @@secret_number
end

def way_too_low?(guess)
  guess < @@secret_number - 5
end

def set_color(message)
  return 'red' if /way/=~message
  return 'green' if /correct/=~message
  return 'ff69b4'
end

def cheat
  if @@cheat == "true"
    settings.cheat_msg
  end
end

get '/' do
  guess = params["guess"].to_i
  @@cheat = params["cheat"]
  message = check_guess(guess)
  erb :index, :locals => {:number => @@secret_number, :message => message}
end
