module Ltk
  class LabelPainter
    getter label, painter

    delegate ctx, fill_round_rect, font_extents, to: painter
    delegate height, text, width, to: label

    def initialize(@label : Label, @painter : Painter)
    end

    def draw
      extents = ctx.text_extents text
      x = case label.alignment
      when .right? then width - extents.width
      when .h_center? then (width - extents.width) / 2.0_f64
      else
        0.0_f64
      end
      y = case label.alignment
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
