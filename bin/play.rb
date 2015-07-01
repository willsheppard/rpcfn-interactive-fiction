#!/usr/bin/env ruby

require "logger"

class Game

  # Config
  # (capitals changes the scope?)
  DATA_FILE = "data/petite_cave.if"
  DEBUG_FLAG = 1

  # Logging
#  log = Logger.new File.new('test.log')
#  log.debug "debugging info"
# Error: file not open for writing

  def initialize(story_path, options={})
    @input  = options.fetch(:input)  { $stdin  }
    @output = options.fetch(:output) { $stdout }
  end

  def start!
    debug "data file = "+DATA_FILE
#    data_file_path = File.expand_path(
#      File.dirname(__FILE__)
#    )
#      + '/' + DATA_FILE
#    puts "data_file = "+data_file
    
    text = File.read(DATA_FILE)
    puts "text = " + text
    
    # TODO: Implement a state-machine parser
    # TODO: Move parsing logic to a separate file/class
    # TODO: Refactor to a recursive-descent parser

    # CODE PLAN
    # 1. Parse the data file blindly, load into a hash
    # 2. Verify data integrity

    # split text on \n
    section = false
    # for each line in text
    # if ! section?

    ##valid_section_names = %w{Room Object Action Synonyms}
    data = Hash.new # big hash containing a representation of all game objects

    # Naming conventions:
    #
    # section_type @section_name:
    #   property_type: property_content
    #
    # Example data:
    #
    # Room @building:
    #   Title: inside building
    #   Description:
    #     You are inside a building

    lines = text.split("\n")
    lines.each { |line|
        line = line.chomp

        puts "LINE = "+line
        if line == "" then section = false end

        # if line starts with a section name
        #valid_section_names.each { |valid_section_name|
            #if /Ruby/.match("The future is Ruby")
            #if line =~ /^#{Regexp.quote( valid_section_name )}/
            if line =~ /^\S/ then
                # e.g. Room Object Action Synonyms
                section = true
                # split line
                line_parts = line.split(" ")
                object_type = line_parts[0]
                object_name = line_parts[1] # nil for Synonyms
                data[ object_type ][ object_name ] = Hash.new
                next
            end
            if section = true then
                if line =~ /^\s\s\S/ then
                    # Second level
                    line = line.strip
                    line_parts = line.split(" ")
                    # for type/name read label/content
                    object_type = line_parts[0]
                    object_name = line_parts[1] # may be nil
                    # We either have just the label, or the label and content

                    #if object_name.nil?
                    # how do I compare nil?


                    data[ object_type ][ object_name ] = Hash.new
                    next
                elsif line =~ /^\s\s\s\s\S/
                    # Third level
                    if 
                end # if second level
            end
        }
    }

    raise NotImplementedError, "Implement me!"
  end

  def debug(message)
    if DEBUG_FLAG
      puts message
    end
  end

  def play!
    start!
    execute_one_command! until ended?
  end

  def execute_one_command!
    raise NotImplementedError, "Implement me!"
  end

  def ended?
    raise NotImplementedError, "Implement me!"
  end
end

if $PROGRAM_NAME == __FILE__
  #story_path = ARGV[0]
  story_path = "petite_cave.if"
  unless story_path
    warn "Usage: #{$PROGRAM_NAME} STORY_FILE"
    exit 1
  end
  game = Game.new(story_path)
  game.play!
end
