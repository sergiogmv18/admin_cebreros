class Menu {
  final String name;
  final String image;
  final String route;
  Menu(this.name, this.image, this.route);
}

var allMenu = [
  {"name": "El Cielo de Cebreros", 'logo': "assets/images/logo_elcielodecebreros.png", "route": "/el_cielo_de_cebreros/home"},
  {"name": "Cebreterra", 'logo': "assets/images/logo_cebreterra.png", "route": "/cebreterra/home"},
];

List<Menu> getAllMnenu = allMenu.map((Map<String, dynamic> item) =>Menu(item['name'], item['logo'], item['route'])).toList();