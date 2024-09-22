import Foundation
import Cairo

class ClockWidget: Widget {
    override func draw() {
        let surface = cairo_image_surface_create(CAIRO_FORMAT_ARGB32, width, height)
        let cr = cairo_create(surface)

        // Get the current time
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let timeString = formatter.string(from: date)

        // Draw background
        cairo_set_source_rgba(cr, 0, 0, 0, 0.5)  // Semi-transparent black
        cairo_paint(cr)

        // Draw time
        cairo_set_source_rgb(cr, 1, 1, 1)  // White text
        cairo_select_font_face(cr, "Sans", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
        cairo_set_font_size(cr, 40)
        cairo_move_to(cr, 20, 50)
        cairo_show_text(cr, timeString)

        cairo_destroy(cr)
        cairo_surface_destroy(surface)

        // Send the surface to be rendered via wlroots
        sendSurfaceToWayland(surface, x: x, y: y, width: width, height: height)
    }
}
