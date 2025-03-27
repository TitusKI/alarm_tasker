import 'package:intl/intl.dart'; // Import the intl package

String formatCompletedDate(DateTime completedAt) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final completedDate =
      DateTime(completedAt.year, completedAt.month, completedAt.day);

  final dateFormat = DateFormat('h:mm a'); // Format for time (e.g., 3:18 PM)
  final dayFormat = DateFormat(
      'EEEE, d MMM @ h:mm a'); // Format for day (e.g., Tuesday, 18 Mar @ 3:32 PM)
  final yearFormat = DateFormat(
      'EEEE, d MMM y @ h:mm a'); // Format for year (e.g., Tuesday, 18 Mar 2023 @ 3:32 PM)

  if (completedDate == today) {
    // Completed today
    return "Completed Today at ${dateFormat.format(completedAt)}";
  } else if (completedDate.year == now.year) {
    // Completed this year, but not today
    return "Completed ${dayFormat.format(completedAt)}";
  } else {
    // Completed in a previous year
    return "Completed ${yearFormat.format(completedAt)}";
  }
}
