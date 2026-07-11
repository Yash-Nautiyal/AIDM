enum CalendarDateFilter {
  anyTime('Any time', 'Any'),
  today('Today', 'Today'),
  yesterday('Yesterday', 'Yesterday'),
  last7Days('Last 7 days', 'Last 7 days'),
  last30Days('Last 30 days', 'Last 30 days'),
  year('Year', 'Year');

  const CalendarDateFilter(this.label, this.chipLabel);

  final String label;
  final String chipLabel;
}

enum CalendarTypeFilter {
  any('Any', 'Any'),
  recurring('Recurring', 'Recurring'),
  nonRecurring('Non recurring', 'Non recurring');

  const CalendarTypeFilter(this.label, this.chipLabel);

  final String label;
  final String chipLabel;
}
