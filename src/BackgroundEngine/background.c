#include "stb_image.h"
#include <wlr/util/log.h>
#include <wlr/types/wlr_compositor.h>
#include <wlr/backend.h>

struct background {
    struct wlr_surface *surface;
    struct wlr_texture *texture;
};

// Initialize and load the background image
void setup_background(struct wlroots_state *state, struct background *bg, const char *image_path) {
    int width, height, channels;
    unsigned char *data = stbi_load(image_path, &width, &height, &channels, STBI_rgb_alpha);

    if (!data) {
        wlr_log(WLR_ERROR, "Failed to load background image");
        return;
    }

    // Create the surface and texture for the background
    bg->surface = wlr_surface_create(state->display);
    bg->texture = wlr_texture_from_pixels(wlr_backend_get_renderer(state->backend), WL_SHM_FORMAT_ARGB8888, width * 4, width, height, data);

    stbi_image_free(data);
}

// Render the background during the compositor rendering cycle
void render_background(struct background *bg) {
    // Implement the logic to render the texture across the entire screen
    // This should be integrated with the main compositor rendering loop
}
