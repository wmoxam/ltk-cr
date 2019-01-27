require "./widget_painter"

module Ltk
  class PushButtonPainter < WidgetPainter
    delegate down, focused?, hover, to: widget

    def initialize(@widget : PushButton, @painter : Painter)
    end

    def draw
      draw_background!
      draw_borders!
      draw_text!
    end

    private def draw_background!
      ctx.set_source_rgb 0.3_f64, 0.3_f64, 0.3_f64
      ctx.rectangle 0.0_f64, 0.0_f64, width.to_f, height.to_f
      ctx.fill
    end

    private def draw_borders!
      w = width
      h = height

      if focused?
        ctx.set_source_rgb 83.0_f64 / 255.0_f64, 160.0_f64 / 255.0_f64, 237.0_f64 / 255.0_f64
      else
        pattern = Pattern.create_linear 0.0_f64, 0.0_f64, 0.0_f64, h.to_f
        if down
          pattern.add_color_stop 0.0_f64, 46.0_f64 / 255.0_f64, 46.0_f64 / 255.0_f64, 46.0_f64 / 255.0_f64
          pattern.add_color_stop 1.0_f64, 60.0_f64 / 255.0_f64, 60.0_f64 / 255.0_f64, 60.0_f64 / 255.0_f64
        else
          pattern.add_color_stop 0.0_f64, 0.25_f64, 0.25_f64, 0.25_f64
          pattern.add_color_stop 1.0_f64, 0.18_f64, 0.18_f64, 0.18_f64
        end
        ctx.source = pattern
      end
      fill_round_rect 0, 0, w, h, 3

      w -= 2; h -= 2
      pattern = Pattern.create_linear 0.0_f64, 0.0_f64, 0.0_f64, h.to_f
      if down
        pattern.add_color_stop 0.0_f64, 63.0_f64 / 255.0_f64, 63.0_f64 / 255.0_f64, 63.0_f64 / 255.0_f64
        pattern.add_color_stop 1.0_f64, 62.0_f64 / 255.0_f64, 62.0_f64 / 255.0_f64, 62.0_f64 / 255.0_f64
      else
        pattern.add_color_stop 0.0_f64, 0.44_f64, 0.44_f64, 0.44_f64
        pattern.add_color_stop 1.0_f64, 0.35_f64, 0.35_f64, 0.35_f64
      end
      ctx.source = pattern
      fill_round_rect 1, 1, w, h, 3

      w -= 2; h -= 2
      pattern = Pattern.create_linear 0.0_f64, 0.0_f64, 0.0_f64, h.to_f
      if down
        pattern.add_color_stop 0.0_f64, 71.0_f64 / 255.0_f64, 71.0_f64 / 255.0_f64, 71.0_f64 / 255.0_f64
        pattern.add_color_stop 1.0_f64, 65.0_f64 / 255.0_f64, 65.0_f64 / 255.0_f64, 65.0_f64 / 255.0_f64
      else
        c1 = hover ? 0.45_f64 : 0.40_f64
        c2 = hover ? 0.36_f64 : 0.33_f64
        pattern.add_color_stop 0.0_f64, c1, c1, c1
        pattern.add_color_stop 1.0_f64, c2, c2, c2
      end
      ctx.source = pattern
      fill_round_rect 2, 2, w, h, 3
    end

    private def draw_text!
      ctx.select_font_face("Sans",
        Cairo::FontSlant::Normal,
        Cairo::FontWeight::Normal)
      ctx.font_size = 12.0_f64

      extents = ctx.text_extents text
      x = (width / 2.0_f64) - (extents.width / 2 + extents.x_bearing)
      y = (height / 2.0_f64) - (font_extents.height / 2 - font_extents.ascent)

      ctx.move_to x, y

      ctx.set_source_rgb 0.85_f64, 0.85_f64, 0.85_f64
      ctx.show_text text
    end
  end
end
