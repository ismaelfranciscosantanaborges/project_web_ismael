import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formulario_web_t2/cubit/cubit/register_cubit.dart';
import 'package:formulario_web_t2/screens/screens.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key key}) : super(key: key);
  static const String route = 'DetailsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terisco'),
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case RegisterInitial:
              return Center(
                child: Text('Aun no tines ningun contacto...'),
              );
            default:
              return ListView(
                children: [
                  if (state.values.users.length > 0)
                    for (var user in state.values.users)
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AddAndUpdateContactScreen.route,
                              arguments: user);
                        },
                        title: Text('${user.firstName} ${user.lastName}'),
                        subtitle: Text('${user.telefono}'),
                        trailing: IconButton(
                            icon: Icon(Icons.cancel), onPressed: () {}),
                      )
                  else
                    Center(
                      child: Text('Aun no tienes ningun contacto ...'),
                    ),
                ],
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddAndUpdateContactScreen.route);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
