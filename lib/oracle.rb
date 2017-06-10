class Oracle
  @@URL = "../data/"
  def initialize
    @npcs = [:extra, :crowd, :major, :minor, :world]
    @allignments = [:ally, :friendly, :wary, :hostile, :neutral]
    @trends = [:positive, :negative, :ambigous, :close, :open]
    @actions = load('actions.txt')
    @characters = load('characters.txt')
    @subjects = load('subjects.txt')
    @arcana = load('arcana.txt')
  end

  def event
    event_str =  "Character #{character}, #{allignment}.\n"
    event_str += "* The event is #{trend} for this character\n"
    event_str += "* Subect: #{subject} ::: Action: #{action}"
  end

  def cross
    response = []
    11.times {
      candidate = arcana
      while response.include?(candidate)
        candidate = arcana
      end
      response << candidate
    }
    response
  end

  def yes_no(likelihood=6)
    result = DICE.sample / likelihood
    output = "#{action} + #{arcana}"
    if result > 2
      "Yes and: #{output}"
    elsif result > 4/3
      "Yes"
    elsif result >= 1
      "Yes but: #{output}"
    elsif result > 3/4
      "Not but: #{output}"
    elsif result > 1/2
      "No"
    else
      "No and: #{output}"
    end
  end

  private

  def character
    if DICE.sample <= 4
      @characters.sample
    else
      @npcs.sample
    end
  end

  def trend
    @trends.sample
  end

  def subject
    @subjects.sample
  end

  def action
    @actions.sample
  end

  def allignment
    @allignments.sample
  end

  def arcana
    @arcana.sample
  end

  def load(filename)
    url = @@URL + filename
    x = []
    File.readlines(url).each {|line| x << line.chomp}
    x
  end

end
