import CGtk
import Yams

// Class to manage Control Center
class ControlCenter {
    private var controlCenterWindow: UnsafeMutablePointer<GtkWidget>?

    init() {
        // Initialize GTK or any required setup for the Control Center
        gtk_init(nil, nil)
    }

    // Function to display the control center window
    func showControlCenter() {
        controlCenterWindow = gtk_window_new(GTK_WINDOW_TOPLEVEL)
        gtk_window_set_title(GTK_WINDOW(controlCenterWindow), "Control Center")
        gtk_window_set_default_size(GTK_WINDOW(controlCenterWindow), 400, 300)

        // Add widgets to control center (buttons, sliders, etc.)
        let label = gtk_label_new("This is the Control Center")
        gtk_container_add(GTK_CONTAINER(controlCenterWindow), label)

        gtk_widget_show_all(controlCenterWindow)
    }

    // Handle YAML config parsing
    func loadConfig(_ configString: String) {
        if let config = try? Yams.load(yaml: configString) as? [String: Any],
           let controls = config["controls"] as? [String: Any],
           let controlCenterConfig = controls["control_center"] as? [String: Any] {
            if let trigger = controlCenterConfig["trigger"] as? String,
               trigger == "button_click" {
                // Add a button to the main window to trigger Control Center
                let button = gtk_button_new_with_label("Open Control Center")
                g_signal_connect_swift(button, "clicked", G_CALLBACK { _ in
                    self.showControlCenter()
                })
            }
        }
    }
}
