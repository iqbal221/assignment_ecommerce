class Urls {
  static const String _baseUrl = "https://ecom-rs8e.onrender.com/api";
  static const String signUpUrl = "$_baseUrl/auth/signup";
  static const String signInUrl = "$_baseUrl/auth/login";
  static const String verifyOtpUrl = "$_baseUrl/auth/verify-otp";
  static const String homeSlidersUrl = "$_baseUrl/slides";
  static String categoryListUrl(int pageSize, int pageNo) =>
      "$_baseUrl/categories?count=$pageSize&page=$pageNo";
  static String productsUrl(int pageSize, int pageNo) =>
      "$_baseUrl/products?count=$pageSize&page=$pageNo";
  static String productDetailsUrl(String productId) =>
      "$_baseUrl/products/id/$productId";
  static String productsByCategoryUrl(
    int pageSize,
    int pageNo,
    String categoryId,
  ) => "$_baseUrl/products?count=$pageSize&page=$pageNo&category=$categoryId";

  static const String cartListUrl = "$_baseUrl/cart";
  static String deleteCartItemUrl(String productId) =>
      "$_baseUrl/cart/$productId";
  static String wishListUrl(int pageSize, int pageNo) =>
      "$_baseUrl/wishlist?count=$pageSize&page=$pageNo";
}
