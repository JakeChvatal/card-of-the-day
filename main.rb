#!/usr/bin/ruby1

require 'optparse'
require 'mtg_sdk'

#┌──────────────────────────────┐
#│ Cardname            3BGGRBSA │
#├──────────────────────────────┤
#│ Artifact Creature - Sorcerer │                
#├──────────────────────────────┤
#│This is the firse line of     │
#│card text. The text should    │
#│maximize the space allotted.  │
#│                              │
#│                              │
#│                              │
#│                              │
#│                              │
#│                              │
#│                    ┌─────────┤
#│                    │ pp / tt │
#└────────────────────┴─────────┘

def get_random_card()
  card = MTG::Card.find(rand(1000))

  return make_card(card)
end

def draw_line(result, cardLen, lineStart, lineEnd) 
  line = "#{lineStart}"

  # first line
  $i = 0
  $num = $max_card_len + 2

  until $i > $num  do
    line = line << "─"
    $i +=1;
  end

  line = line << "#{lineEnd}\n"
  result = result << line
end

def wrap_text(result, cardLen, text)
  result = result << "│ "
  $curLen = 0
  text.split(" ").each do |i|
    if(($curLen + i.length + 1) <(cardLen + 2))
      result = result << "#{i} "
      $curLen += (i.length + 1)
    else

      $i = 0
      $num = cardLen - $curLen

      until $i > $num do
        result = result << " "
        $i += 1;
      end

      result << " │\n│ #{i} "
      $curLen = i.length
    end
  end

  $i = 0
  $num = cardLen - $curLen

  until $i > $num do
    result = result << " "
    $i += 1;
  end
  result = result << "│\n"
end

def make_card(card)
  ## $name_cost =  "  #{card.name}#{card.mana_cost}   "
  $max_card_len = 30 # $name_cost.length < card.type.length + 2 ? card.type.length + 2 : $name_cost.length  
  result = ""

  # first line
  draw_line(result, $max_card_len, "┌─", "─┐")

  # second line
  line = "│ #{card.name}"

  $i = 0
  $num = $max_card_len - card.name.length + 2
  if card.mana_cost
    $num = $num - card.mana_cost.length
  end

  until $i > $num do
    line = line << " "
    $i +=1;
  end
  if card.mana_cost
  line  = line << "#{card.mana_cost} │\n"
  else
    line = line << " │\n"
  end

  result = result << line

  #third line
  draw_line(result, $max_card_len,  "├─", "─┤")

  # fourth line
  line = "│ #{card.type}"

  $i = 0
  $num = $max_card_len - card.type.length + 3

  until $i > $num do
    line = line << " "

    $i +=1;
  end

  line  = line << "│\n"
  result = result << line


  #fifth line
  line = "├─"

  $i = 0
  $num = $max_card_len + 2

  until $i > $num  do
    line = line << "─"
    $i +=1;
  end

  line = line << "─┤\n"
  result = result << line

  # adds card text if it exists
  if card.text
    wrap_text(result, $max_card_len, card.text)
  end

  # puts adds power and toughness if available
  if card.power
    line ="│"

    $subStr = "│ " << card.power << " / "<< card.toughness << " │\n"
    $realLen = $subStr.length 
    $i = 0
    $num = $max_card_len - $realLen
    until $i > $num do
      line = line << " "
      $i +=1;
    end

    line = line << "┌─"
    $i = 0
    $num =  $realLen

    until $i > $num  do
      line = line << "─"
      $i +=1;
    end

    line = line << "─┤\n"

    line = line << "│"
    $i = 0
    $num = $max_card_len - $realLen
    until $i > $num do
      line = line << " "
      $i +=1;
    end

    line = line << $subStr 

    result = result << line
  end

  # last line
  draw_line(result, $max_card_len, "└─", "─┘")

  return result
end



def get_card_by_name(name)
  return make_card(MTG::Card.where(name: name).all)
end

options = {}

OptionParser.new do |parser|
  parser.banner = "Usage: main.rb [options]"
  parser.on("-h", "--help", "Shows this help message.") do ||
    puts parser
  end

  parser.on("-c", "--card CARD", "Prints a specific Magic: The Gathering card.") do |v|
    options[:card] = v
  end

  parser.on("-n", "--number NUMBER", Integer, "The number of cards to display.") do |v|
    options[:number] = v
  end
end.parse!

if options[:card] then 
  puts "The card with the name is #{get_card_by_name([:card])}"
else
  options.fetch(:number, 1).times do
    puts "#{ get_random_card() }"
  end 
end
