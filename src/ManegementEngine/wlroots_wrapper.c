#include "wlroots_wrapper.h"
#include <stdlib.h>
#include <wlr/backend.h>
#include <wlr/backend/wayland.h>
#include <wlr/types/wlr_compositor.h>
#include <wlr/util/log.h>

struct wlroots_state {
    struct wl_display *display;
    struct wlr_backend *backend;
    struct widget_manager widget_manager; // Widget management in C
};

struct wlroots_state* init_wayland() {
    wlr_log_init(WLR_DEBUG, NULL);
    struct wlroots_state *state = calloc(1, sizeof(struct wlroots_state));
    state->display = wl_display_create();

    state->backend = wlr_backend_autocreate(state->display, NULL);
    if (!state->backend) {
        wlr_log(WLR_ERROR, "Failed to create backend");
        exit(1);
    }

    // Initialize the widget manager
    widget_manager_init(&state->widget_manager);

    return state;
}

// Function to add Swift-drawn widgets to the Wayland rendering system
void add_widget(struct wlroots_state *state, void (*draw_func)(void *), void *data) {
    struct widget *widget = calloc(1, sizeof(struct widget));
    widget->draw = draw_func;  // Assign the Swift drawing function
    widget->data = data;
    widget_manager_add(&state->widget_manager, widget);
}

void run_wayland(struct wlroots_state *state) {
    widget_manager_draw(&state->widget_manager);
    wl_display_run(state->display);
}
