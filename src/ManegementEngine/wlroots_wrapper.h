#ifndef WLROOTS_WRAPPER_H
#define WLROOTS_WRAPPER_H

struct wlroots_state;

struct wlroots_state* init_wayland();
void run_wayland(struct wlroots_state *state);
void add_widget(struct wlroots_state *state, void (*draw_func)(void *), void *data);

#endif
