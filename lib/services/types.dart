typedef Json = Map<String, dynamic>;

enum AppBarSelection { category, search, filter }

/// Either FilterType.facility for Place filter
/// or FilterType.showcase for Showcase filter
enum FilterType { facility, showcase }

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}
