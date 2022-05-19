class CategoryModel {
  final String color;
  final String title;

  CategoryModel(this.color, this.title);
  static List<CategoryModel> categories = [
    CategoryModel("#FFD506", "Personal"),
    CategoryModel("#5DE61A", "Work"),
    CategoryModel("#D10263", "Meeting"),
    CategoryModel("#3044F2", "Study"),

  ];

}