import Foundation

// Initialize Wayland
let state = init_wayland()

// Create a clock widget
let clockWidget = ClockWidget(x: 50, y: 50, width: 200, height: 100)

// Add the clock widget to the system
add_widget(state, clockWidget.draw, &clockWidget)

// Run the compositor
run_wayland(state)
