require "prawn"
require "prawn/table"

module CRC
  class CardRenderer
    include Prawn::View

    def initialize(cards)
      cards.each do |e| 
        case e
        when :break
          start_new_page
        when :hr
         mask(:stroke_color) do
           stroke_color "999999"
           stroke_horizontal_rule
         end

         move_down 20
        else
          draw_card(e)
        end
      end 
    end

    def draw_card(card)
      bounding_box [bounds.width*0.15, cursor], :height => 150, :width => bounds.width*0.7 do
        stroke_bounds

        add_dest card[:candidate], dest_xyz(bounds.absolute_left, y)
        move_down 5
        
        indent(10) do
          text card[:candidate], :size => 16
        end

        stroke_horizontal_rule

        ypos = cursor

        move_down 10

        float do
          indent(10) do
            card[:responsibilities].each do |e|
              text "• #{e}", :size => 11
              move_down 5
            end
          end
        end

        indent(bounds.width*0.6 + 10) do
          card[:collaborators].each do |e|
            text %{›› <link anchor="#{e}">#{e}</link>}, :size => 11,
                                                       :inline_format => true
            move_down 5
          end
        end

        stroke_vertical_line ypos, bounds.bottom, :at => bounds.left + bounds.width * 0.6
      end
      move_down 20
    end
  end
end
