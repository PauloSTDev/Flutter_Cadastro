import 'package:aula_1/models/user.dart';
import 'package:aula_1/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData ={};

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)
    print(user);

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final bool isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();

                Provider.of<Users>(context, listen: false).put(User(
                  id: _formData['id'].toString(),
                  name: _formData['name'].toString(),
                  email: _formData['email'].toString(),
                  avatarUrl: _formData['avatarUrl'].toString(),

                ));

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child:Column(
            children: <Widget> [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if(value == null || value.trim().isEmpty){
                    return 'Nome inválido';
                  }

                  if(value.trim().length < 3) {
                    return 'Nome muito pequeno. minimo de 3 letras';
                  }

                  return null;
                },
                onSaved: (value) => _formData['name'] = value.toString(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _formData['email'] = value.toString(),
              ),
              TextFormField(
          decoration:InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formData['AvatarUrl'] = value.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
