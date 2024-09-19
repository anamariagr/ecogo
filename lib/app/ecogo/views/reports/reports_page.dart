import 'package:flutter/material.dart';
import 'package:ecogo/core/components/app_drawer.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    final List<Map<String, String>> noticias = [
      {
        'titulo': 'Nuevo plan de reciclaje en la ciudad',
        'descripcion':
            'El alcalde anuncia un nuevo plan de reciclaje para mejorar el manejo de residuos sólidos.',
        'imageUrl': 'lib/core/assets/new.png',
      },
      {
        'titulo': 'Incremento en el reciclaje de plásticos',
        'descripcion':
            'Este año, la ciudad ha visto un incremento del 25% en el reciclaje de plásticos.',
        'imageUrl': 'lib/core/assets/vertedero-2.png',
      },
      {
        'titulo': 'Innovaciones en el reciclaje de vidrio',
        'descripcion':
            'Nuevas tecnologías permiten reciclar vidrio de manera más eficiente y rápida.',
        'imageUrl': 'lib/core/assets/vertedero-img.png',
      },
      {
        'titulo': 'Campaña de concienciación ambiental',
        'descripcion':
            'Se lanza una campaña de concienciación para reducir los desechos y fomentar el reciclaje.',
        'imageUrl': 'lib/core/assets/glass.png',
      },
       {
        'titulo': 'Incremento en el reciclaje de plásticos',
        'descripcion':
            'Este año, la ciudad ha visto un incremento del 25% en el reciclaje de plásticos.',
        'imageUrl': 'lib/core/assets/vertedero-2.png',
      },
      {
        'titulo': 'Innovaciones en el reciclaje de vidrio',
        'descripcion':
            'Nuevas tecnologías permiten reciclar vidrio de manera más eficiente y rápida.',
        'imageUrl': 'lib/core/assets/vertedero-img.png',
      },
      {
        'titulo': 'Campaña de concienciación ambiental',
        'descripcion':
            'Se lanza una campaña de concienciación para reducir los desechos y fomentar el reciclaje.',
        'imageUrl': 'lib/core/assets/glass.png',
      },
    ];

    return Scaffold(
      drawer: AppDrawer(pageController: pageController),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(179, 38, 134, 54),
                Color.fromARGB(176, 73, 184, 119),
                Color.fromARGB(176, 75, 192, 123),
                Color.fromARGB(175, 64, 161, 105),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) {
                        return IconButton(
                          icon: const Icon(Icons.menu),
                          color: const Color.fromARGB(255, 238, 238, 238),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    ),
                    Row(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.monetization_on, color: Colors.amber),
                            SizedBox(width: 5),
                            Text(
                              '300',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 238, 238, 238),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          color: const Color.fromARGB(255, 238, 238, 238),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 0, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mis Reportes',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 56, 56, 56),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 0),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, bottom: 20, top: 20),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: noticias.length,
                            itemBuilder: (context, index) {
                              final noticia = noticias[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Image.asset(
                                        noticia['imageUrl']!,
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            noticia['titulo']!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            noticia['descripcion']!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
