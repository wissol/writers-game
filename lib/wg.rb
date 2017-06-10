DICE = (1..12).to_a
require_relative 'oracle'
class Scene
  def run(chaos=7)
    log = "\n\n================="
    log += "\n\tNew Scene"
    log += "\n\n=================\n\n"
    puts " What's this scene all about?"
    log += "\n#{gets}"
    if DICE.sample > chaos
      log += "\nIt went as intended"
      interrupt = false
    else
      log += "\nInterrupt!:\n" + Oracle.new.event
      interrupt = true
    end
    puts log
    [log, interrupt]
  end
end

class Logger
  def log(data)
    File.open("../data/log.txt", 'a') { |file| file.write(data) }
  end

  def rewrite(data)
    File.open("../data/log.txt", 'w+') { |file| file.puts data }
  end
end

class Game
  def initialize
    @ui = UI.new
    @scribe = Logger.new
    @chaos = File.read('../data/chaos.txt').to_i
  end

  def new_adventure
    @chaos = validate_chaos(@ui.input "Starting Chaos 1..9, if in doubt just press enter")
    logdata = @ui.input("The name of your adventure")
    @scribe.rewrite(logdata)
    # characters
  end

  def run(logdata="")
    delfos = Oracle.new
    choice = @ui.menu
    logdata = ""
    case choice
    when :a
      logdata = new_adventure
    when :n
      logdata, more_chaos = Scene.new.run(@chaos)
      more_chaos ? inc_chaos : dec_chaos
    when :y
      logdata += @ui.header("A new question")
      logdata += @ui.input("Ask away")
      answer = "The answer was #{delfos.yes_no}"
      logdata += answer
      puts answer
    when :o
      logdata += @ui.header("A new open question")
      logdata += "\n #{@ui.input('Ask away')}\n"
      logdata += @ui.show_cross(delfos.cross)
    when :q
      exit
    end
    @scribe.log(logdata)
    run
  end

  private
  def validate_chaos(raw_chaos)
    raw_chaos == "" ? int_chaos = 7 : int_chaos = raw_chaos.to_i
    (1..9).include?(int_chaos) ? int_chaos : validate_chaos(@ui.input "Starting Chaos 1..9, if in doubt just press enter")
  end

  def inc_chaos
    @chaos > 9 ? @chaos : @chaos += 1
  end

  def dec_chaos
    @chaos < 3 ? @chaos : @chaos -= 1
  end

end

class UI
  def input(mssg)
    print "#{mssg} > "
    gets.chomp
  end

  def header(str)
    "\n #{str} \n#{'=' * (2 + str.length)}\t\t"
  end

  def menu
    h2 = header "Menu"
    items = {:a => "New adventure", :n => "New scene", :y => "Yes/No Question", :o=> "Open Question", :q => "Quit"}
    puts h2
    items.each_key {|k| puts "* #{k}, #{items[k]}"}
    raw_selection = ""
    until items.include?(raw_selection) do
      raw_selection = input("Choose an item").to_sym
    end
    raw_selection
  end

  def show_cross(x)
    a = header("Thus say the oracle ")
    a += "\n#{x[0]}\t\t#{x[1]}\t\t#{x[2]}"
    a += "\n\t\t#{x[3]}"
    a += "\n#{x[4]}\t\t#{x[5]}\t\t#{x[6]}"
    a += "\n\t\t#{x[7]}"
    a += "\n#{x[8]}\t\t#{x[9]}n\t\t#{x[10]}"
    puts a
    a
  end
end

Game.new.run
