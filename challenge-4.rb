def separe_string_from_game_word(string)
  string.scan(/Game.*?(?= Game|$)/)
end

def separe_string(variable)
  new_array = separe_string_from_game_word(variable)
  other_array = []
  new_array.each do |game|
    other_array << game.split(/:|;/)
  end
  other_array
end

def make_array_of_arrays(array)
  identify_game_id = /Game (\d+)/
  new_array = []
  new_new_array = []
  array.each do |other_array|
    other_array.each do |word|
      if word =~ /(Game|red|green|blue)/
        red_regex = /(\d+) red/
        obtain_number_of_color_red = word.match(red_regex)
        red_number = obtain_number_of_color_red ? obtain_number_of_color_red[1] : nil

        green_regex = /(\d+) green/
        obtain_number_of_color_green = word.match(green_regex)
        green_number = obtain_number_of_color_green ? obtain_number_of_color_green[1] : nil

        blue_regex = /(\d+) blue/
        obtain_number_of_color_blue = word.match(blue_regex)
        blue_number = obtain_number_of_color_blue ? obtain_number_of_color_blue[1] : nil

        obtain_game_id = word.match(identify_game_id)
        game_number = obtain_game_id ? obtain_game_id[1] : nil

        new_other_array = [red_number.to_i, green_number.to_i, blue_number.to_i]

        if word.include? "Game"
          obtain_game_id = word.match(identify_game_id)
          game_number = obtain_game_id ? obtain_game_id[1] : nil
          new_array << game_number
        end
        new_array << new_other_array
        new_array
      end
    end
  end
  new_array
end


def reorganize_array(original_array)
  reorganized_array = []
  current_array = []

  original_array.each do |element|
    if element.is_a?(String) # Suponemos que los números de juego son cadenas
      reorganized_array << current_array unless current_array.empty?
      current_array = [element] # Comienza un nuevo subarray
    else
      current_array << element # Añade el subarray de números al array actual
    end
  end
  reorganized_array << current_array unless current_array.empty? # Añadir el último subarray

  reorganized_array
end


def obtain_ids(array)
  red_cubes   = 12
  blue_cubes  = 14
  green_cubes = 13
  matching_games = []

  array.each do |game_array|
    game_id = game_array[0]
    numbers_arrays = game_array[1..-1]
    if numbers_arrays.all? { |numbers| numbers[0] <= red_cubes && numbers[1] <= green_cubes && numbers[2] <= blue_cubes }
      matching_games << game_id
    end
  end
  matching_games
end

def sumatory(array)
  array.map(&:to_i).inject(0,:+)
end

def final_game(input)
  form_array     = separe_string(input)
  original_array = make_array_of_arrays(form_array)
  orginize_array = reorganize_array(original_array)
  ids            = obtain_ids(orginize_array)
  sumatory(ids)
end

p final_game(variable)
