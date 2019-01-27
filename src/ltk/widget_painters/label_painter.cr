require "./widget_painter"

module Ltk
  class LabelPainter < WidgetPainter
    delegate alignment, to: widget

    def initialize(@widget : Label, @painter : Painter)
    end

    def draw
      extents = ctx.text_extents text
      x = case alignment
      when .right? then width - extents.width
      when .h_center? then (width - extents.width) / 2.0_f64
      else
        0.0_f64
      end
      y = case alignment
      when .top? then font_extents.height
      when .bottom? then height.to_f64 - font_extents.descent
      else
        (height + font_extents.ascent) / 2.0_f64
      end

      ctx.move_to x, y

      ctx.set_source_rgb 0.85_f64, 0.85_f64, 0.85_f64
      ctx.show_text text
    end

  end
end
