import 'package:aula_04_16_03_2022_contato/ui/components/components.dart';
import 'package:aula_04_16_03_2022_contato/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _assuntoController = TextEditingController();
  final _mensagemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contato App"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: abrirSobre,
              icon: const Icon(Icons.help_outline)
          ),
        ],
      ),
      body: ListView(
        children: [
          CampoTexto(_nomeController, "Digite seu nome"),

          CampoTexto(_emailController,
            "Digite seu e-mail",
            teclado: TextInputType.emailAddress,
            prefixo: "@ ",
          ),

          CampoTexto(_assuntoController, "Assunto do e-mail"),
          CampoTexto(_mensagemController, "Mensagem do e-mail"),

          BotaoQuadrado("Enviar", enviarEmail),
        ],
      ),
    );
  }

  void enviarEmail() async {
    const usuario = "contato@melhoresradios.com.br";
    const senha = "Nao_Vou_Colocar_a_Senha";

    final smtpServer = gmail(usuario, senha);

    final mensagem = Message()
      ..from = const Address(usuario, "Contato")
      ..recipients.add(usuario)
      ..subject = _assuntoController.text
      ..text = """Nome: ${_nomeController.text},
          E-mail: ${_emailController.text},
          Mensagem: ${_mensagemController.text}""";

    await send(mensagem, smtpServer);

    setState(() {
      _nomeController.clear();
      _emailController.clear();
      _assuntoController.clear();
      _mensagemController.clear();
    });
  }

  void abrirSobre() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SobrePage())
    );
  }
}