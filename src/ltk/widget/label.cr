require "x11"

require "../base/painter"
require "../enums/alignment"
require "./widget"

module Ltk
  class Label < Widget
    getter alignment : Alignment = Alignment::Left | Alignment::VCenter
    getter text : String = ""
    property associated_widget : Widget? = nil

    def initialize(parent = nil)
      super parent
    end

    def initialize(@text : String, parent = nil)
      super parent
    end

    protected def mouse_down_event(event : MouseEvent)
      super
      if has_associated_widget?
        @associated_widget.not_nil!.focus!
      end
    end

    protected def paint_event
      widget_painter.draw
    end

    private def widget_painter
      @widget_painter ||= LabelPainter.new self, painter
    end

    private def painter
      @painter ||= Painter.new self
    end

    def alignment=(align : Alignment)
      if @alignment != align
        @alignment = align
        repaint
      end
    end

    def text=(text : String)
      if @text != text
        @text = text
        repaint
      end
    end

    def has_associated_widget? : Bool
      !@associated_widget.is_a?(Nil)
    end
  end
end
