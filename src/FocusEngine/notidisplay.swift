import Glibc
import CGtk
import CNotify

// Notification struct to manage notification details
struct Notification {
    var title: String
    var message: String
    var position: (x: Int, y: Int)
}

// Notification manager for displaying notifications
class NotificationManager {
    private var notifications: [Notification] = []
    private let screenWidth = 1920
    private let screenHeight = 1080
    private var topRightCorner = (x: 1600, y: 20)
    private let notificationWidth = 300
    private let notificationHeight = 100
    private let padding = 10

    init() {
        // Initialize GTK
        gtk_init(nil, nil)
    }

    // Function to display the notification on the screen
    func displayNotification(title: String, message: String) {
        var position = topRightCorner
        if notifications.count > 0 {
            // If there are existing notifications, adjust position below the previous one
            let lastNotification = notifications.last!
            position = (x: topRightCorner.x, y: lastNotification.position.y + notificationHeight + padding)
        }

        let notification = Notification(title: title, message: message, position: position)
        notifications.append(notification)

        // Create GTK Window for the notification
        let window = gtk_window_new(GTK_WINDOW_TOPLEVEL)
        gtk_window_set_title(GTK_WINDOW(window), title)
        gtk_window_set_default_size(GTK_WINDOW(window), notificationWidth, notificationHeight)
        gtk_window_move(GTK_WINDOW(window), position.x, position.y)

        // Create label for the message
        let label = gtk_label_new(message)
        gtk_container_add(GTK_CONTAINER(window), label)

        gtk_widget_show_all(window)

        // Timeout to hide the notification
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            gtk_widget_destroy(window)
            self.notifications.removeFirst()
        }
    }
}

// Initialize the notification system
let notificationManager = NotificationManager()

// Simulate receiving notifications
for i in 1...5 {
    notificationManager.displayNotification(title: "Notification \(i)", message: "This is message \(i)")
    sleep(2)  // Add delay between notifications
}

// Run the GTK main loop to handle events
gtk_main()
