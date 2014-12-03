module CRC
  class CardReader
    def initialize(filename)
      @cards = []

      File.foreach(filename) do |line|
        case line
        when /\s*~~~+\s*/
          @cards << :break
        when /\s*\.\.\.\s*/
          @cards << :hr
        when /##\s+(.*)/
          @cards << { :candidate => $1, :responsibilities => [], :collaborators => [] }
        when /-\s+(.*)\s+/
          @cards.last[:responsibilities] << $1
        when />\s+(.*)\s+/
          @cards.last[:collaborators] << $1
        end
      end
    end

    attr_reader :cards
  end
end
