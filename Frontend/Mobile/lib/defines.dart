// Static Variables
String stored_username = '';
String stored_token = '';
String stored_first = '';
String stored_last = '';
String stored_quantity = '';

// Constants
const ACCENT_COLOUR = 0xFF99C4D9;
const ACCENT_BLUE = 0xFF8FD0ED;
const ACCENT_PINK = 0xFFE96FAB;
const ACCENT_GREY = 0xFF262626;

const BASE_URI = "http://54.201.255.168:8080/";
const REGISTER_FAIL = "Username exists";
const LOGIN_FAIL = "Invalid username/password.";
const ORDER_DELETE_PASS = "deleted";
const ORDER_GET_FAIL = "Invalid username";

const CUPCAKE_ASSETS_PATH = "assets/images/cupcake_builder";

const List<String> base_codes = [
  "chocolate",
  "redvelvet",
  "vanilla",
];
const List<String> base_names = [
  "Chocolate",
  "Red Velvet",
  "Vanilla",
];
const List<double> base_offset = [0, 0.35];

const List<String> frosting_codes = [
  "chocolate",
  "lime",
  "mint",
  "vanilla",
];
const List<String> frosting_names = [
  "Chocolate",
  "Lime",
  "Mint",
  "Vanilla",
];
const List<double> frosting_offset = [0, -0.10];

const List<String> topping_codes = [
  "none",
  "blackberry",
  "cherry",
  "eatMe",
  "heart_sprinkle",
  "orange",
  "pocky",
  "rainbow_sprinkle",
  "star_sprinkle",
  "strawberry",
];
const List<String> topping_names = [
  "None",
  "Blackberry",
  "Cherry",
  "\"Eat Me\" Words",
  "Heart Sprinkles",
  "Orange",
  "Pocky",
  "Rainbow Sprinkles",
  "Stars Sprinkles",
  "Strawberry",
];
const List<List> topping_offsets = [
  [0.000, 0.000],
  [0.075, -0.65],
  [0.075, -0.75],
  [0.075, -0.60],
  [0.075, -0.35],
  [0.075, -0.85],
  [-0.60, -0.50],
  [0.000, -0.35],
  [0.000, -0.35],
  [0.075, -0.85],
];

String getBasePath(String base) {
  return "$CUPCAKE_ASSETS_PATH/base/${base}_base.png";
}

String getFrostingPath(String frosting) {
  return "$CUPCAKE_ASSETS_PATH/frosting/${frosting}_frosting.png";
}

String getToppingPath(String topping) {
  return "$CUPCAKE_ASSETS_PATH/topping/$topping.png";
}
