module Ltk
  abstract class WidgetPainter
    getter widget, painter
    delegate ctx, fill_round_rect, font_extents, to: painter
    delegate height, text, width, to: widget

    abstract def draw
  end
end
