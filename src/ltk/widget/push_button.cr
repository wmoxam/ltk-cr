require "x11"

require "../event/mouse_event"
require "./widget"

module Ltk
  class PushButton < Widget
    getter down : Bool, hover : Bool, text : String

    @hover = false
    @down = false

    def initialize(parent = nil)
      super parent
      @text = ""
    end

    def initialize(@text, parent = nil)
      super parent
    end

    protected def click_event
      super
    end

    protected def enter_event
      super
      @hover = true
      repaint
    end

    protected def leave_event
      super
      @hover = false
      repaint
    end

    protected def key_press_event(event : KeyEvent)
      super
      if event.key_sym == 32_u64
        @down = true
        repaint
      end
    end

    protected def key_release_event(event : KeyEvent)
      super
      if @down && (event.key_sym == 32_u64)
        @down = false
        repaint
        click_event
      end
    end

    protected def mouse_down_event(event : MouseEvent)
      super
      @down = true
      repaint
    end

    protected def mouse_up_event(event : MouseEvent)
      super
      @down = false
      repaint

      r = geometry
      r.x = 0; r.y = 0
      self.click_event if r.contains? event.pos
    end

    protected def paint_event
      widget_painter.draw
    end

    private def widget_painter
      @widget_painter ||= PushButtonPainter.new self, painter
    end

    def text=(@text)
      self.repaint
    end

    def preferred_size : Size
      Size.new(
        Math.max(minimum_width, @text.size * 8 + 10),
        Math.max(minimum_width, 23))
    end
  end
end
