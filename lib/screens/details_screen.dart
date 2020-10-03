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
                child: Text(
                  'Aun no tienes ningun contacto...',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              );
            default:
              if (state.values.users.length > 0)
                return ListView(
                  children: [
                    // for (var user in state.values.users)
                    for (int i = 0; i < state.values.users.length; i++)
                      Container(
                        color: i % 2 == 1 ? Colors.grey[300] : Colors.white,
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AddAndUpdateContactScreen.route,
                                arguments: state.values.users[i]);
                          },
                          title: Text(
                            '${state.values.users[i].firstName} ${state.values.users[i].lastName}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text('${state.values.users[i].telefono}'),
                          trailing: IconButton(
                              icon:
                                  Icon(Icons.close_rounded, color: Colors.red),
                              onPressed: () {
                                context.bloc<RegisterCubit>().deleteUser(i);
                              }),
                        ),
                      )
                  ],
                );
              else
                return Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, AddAndUpdateContactScreen.route),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        'La lista esta vacia',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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
