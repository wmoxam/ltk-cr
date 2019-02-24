module Ltk
  abstract class WidgetPainter
    DEFAULT_FONT = Font.new(
      "Sans",
      12.0_f64,
      FontSlant::Normal,
      FontWeight::Bold
    )

    getter widget, painter
    delegate ctx, fill_round_rect, font_extents, to: painter
    delegate height, text, width, to: widget

    abstract def draw
  end
end
