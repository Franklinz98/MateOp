import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mate_op/animations/astronaut/astronaut.dart';
import 'package:mate_op/animations/rockets/rocket_a.dart';
import 'package:mate_op/backend/firebase/authentication.dart';
import 'package:mate_op/backend/service/service.dart';
import 'package:mate_op/constants/enums.dart';
import 'package:mate_op/models/user.dart';
import 'package:mate_op/provider/mateop_state.dart';
import 'package:mate_op/screens/routes/authentication.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMateOp extends StatelessWidget {
  final MateOpState state;

  const AboutMateOp({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Provider.of<MateOpState>(context, listen: false)
            .setMainScreenLoud(MainScreen.home);
        return false;
      },
      child: SafeArea(
        child: Stack(
          children: [
            RocketAAnim(
              screenSize: screenSize,
              size: Size(58.5, 190.5),
              margin: Size(90.0, 0),
              angle: 28,
              positionOffset: Size(-3, 12),
              alignment: AnimAlignment.centerLeft,
              duration: Duration(seconds: 2),
            ),
            AstronautAnim(
              screenSize: screenSize,
              size: Size(245, 124.6),
              margin: Size(-140.0, 50),
              angle: -31,
              positionOffset: Size(5, 8),
              alignment: AnimAlignment.centerRight,
              duration: Duration(seconds: 3),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 16.0, right: 32.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          title: Text(
                            "Recursos gráficos por Freepik.com",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          onTap: () async {
                            if (await canLaunch('https://Freepik.com')) {
                              await launch('https://Freepik.com');
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Visita Freepik.com!')));
                            }
                          },
                        ),
                        Spacer(),
                        Visibility(
                          visible: this.state.user != null,
                          child: ListTile(
                            title: Text(
                              "Cerrar sesión",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            onTap: () {
                              signOut().then((value) {
                                this.state.setUser(null);
                                this.state.setMainScreen(MainScreen.home);
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: this.state.user == null,
                          child: ListTile(
                            title: Text(
                              "Iniciar sesión",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            onTap: () async {
                              MOUser user;
                              user = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Authentication()),
                              );
                              state.setUser(user);
                              this.state.setMainScreen(MainScreen.home);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Text(
                        """Política de privacidad\nLa Universidad del Norte creó la aplicación MateOp como una aplicación gratuita. Este SERVICIO es provisto por la Universidad del Norte sin costo y está destinado a ser utilizado tal cual.

Esta página se utiliza para informar a los visitantes sobre nuestras políticas con la recopilación, el uso y la divulgación de información personal si alguien decide utilizar nuestro Servicio.

Si elige utilizar nuestro Servicio, entonces acepta la recopilación y el uso de información en relación con esta política. La información personal que recopilamos se utiliza para proporcionar y mejorar el servicio. No usaremos ni compartiremos su información con nadie excepto como se describe en esta Política de Privacidad.

Los términos utilizados en esta Política de privacidad tienen el mismo significado que en nuestros Términos y condiciones, a los que se puede acceder en MateOp a menos que se defina lo contrario en esta Política de privacidad.

Recopilación y uso de información

Para una mejor experiencia, mientras utiliza nuestro Servicio, es posible que le solicitemos que nos proporcione cierta información de identificación personal, que incluye, entre otros, nombre, edad, correo electrónico. La información que solicitamos será retenida por nosotros y utilizada como se describe en esta política de privacidad.

La aplicación utiliza servicios de terceros que pueden recopilar información utilizada para identificarlo.

Enlace a la política de privacidad de los proveedores de servicios externos utilizados por la aplicación

Servicios de Google Play
Google Analytics para Firebase
Firebase Crashlytics
Dato de registro

Queremos informarle que cada vez que utiliza nuestro Servicio, en caso de error en la aplicación, recopilamos datos e información (a través de productos de terceros) en su teléfono llamado Datos de registro. Estos datos de registro pueden incluir información como la dirección de Protocolo de Internet ("IP") de su dispositivo, el nombre del dispositivo, la versión del sistema operativo, la configuración de la aplicación cuando utiliza nuestro Servicio, la hora y fecha de su uso del Servicio y otras estadísticas. .

galletas

Las cookies son archivos con una pequeña cantidad de datos que se utilizan comúnmente como identificadores únicos anónimos. Estos se envían a su navegador desde los sitios web que visita y se almacenan en la memoria interna de su dispositivo.

Este Servicio no utiliza estas "cookies" explícitamente. Sin embargo, la aplicación puede utilizar códigos de terceros y bibliotecas que utilizan "cookies" para recopilar información y mejorar sus servicios. Tiene la opción de aceptar o rechazar estas cookies y saber cuándo se envía una cookie a su dispositivo. Si decide rechazar nuestras cookies, es posible que no pueda utilizar algunas partes de este Servicio.

Proveedores de servicio

Podemos emplear empresas e individuos de terceros por las siguientes razones:

Para facilitar nuestro Servicio;
Para proporcionar el Servicio en nuestro nombre;
Para realizar servicios relacionados con el servicio; o
Para ayudarnos a analizar cómo se utiliza nuestro Servicio.
Queremos informar a los usuarios de este Servicio que estos terceros tienen acceso a su Información personal. El motivo es realizar las tareas que se les asignen en nuestro nombre. Sin embargo, están obligados a no divulgar ni utilizar la información para ningún otro propósito.

Seguridad

Valoramos su confianza al proporcionarnos su información personal, por lo que nos esforzamos por utilizar medios comercialmente aceptables para protegerla. Pero recuerde que ningún método de transmisión a través de Internet o método de almacenamiento electrónico es 100% seguro y confiable, y no podemos garantizar su absoluta seguridad.

Enlaces a otros sitios

Este Servicio puede contener enlaces a otros sitios. Si hace clic en un enlace de un tercero, se le dirigirá a ese sitio. Tenga en cuenta que estos sitios externos no son operados por nosotros. Por lo tanto, le recomendamos encarecidamente que revise la Política de privacidad de estos sitios web. No tenemos control ni asumimos ninguna responsabilidad por el contenido, las políticas de privacidad o las prácticas de sitios o servicios de terceros.

Privacidad de los niños

Estos Servicios no se dirigen a nadie menor de 13 años. No recopilamos a sabiendas información de identificación personal de niños menores de 13 años. En caso de que descubramos que un niño menor de 13 años nos ha proporcionado información personal, la eliminamos inmediatamente de nuestros servidores. Si usted es padre o tutor y sabe que su hijo nos ha proporcionado información personal, comuníquese con nosotros para que podamos realizar las acciones necesarias.

Cambios a esta política de privacidad

Es posible que actualicemos nuestra Política de privacidad de vez en cuando. Por lo tanto, le recomendamos que revise esta página periódicamente para ver si hay cambios. Le notificaremos de cualquier cambio publicando la nueva Política de privacidad en esta página.

Esta política es efectiva a partir del 2020-11-23

Contáctenos

Si tiene alguna pregunta o sugerencia sobre nuestra Política de Privacidad, no dude en contactarnos en mateopuninorte@gmail.com.

Esta página de política de privacidad fue creada en privacypolicytemplate.net y modificada / generada por App Privacy Policy Generator""",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
