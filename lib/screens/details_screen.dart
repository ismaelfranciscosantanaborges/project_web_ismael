import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formulario_web_t2/cubit/cubit/register_cubit.dart';
import 'package:formulario_web_t2/helpers/details_helper.dart';
import 'package:formulario_web_t2/models/user.dart';
import 'package:formulario_web_t2/screens/screens.dart';
import 'package:formulario_web_t2/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key key}) : super(key: key);
  static const String route = 'DetailsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TERISCO'),
      ),
      body: Responsive(
        mobile: BodyDetailsMobile(),
        desktop: BodyDetailsDesktop(),
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

class BodyDetailsMobile extends StatelessWidget {
  const BodyDetailsMobile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
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
                      color: i % 2 == 1 ? Colors.grey[200] : Colors.white,
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
                            icon: Icon(Icons.close_rounded, color: Colors.red),
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
    );
  }
}

class BodyDetailsDesktop extends StatelessWidget {
  const BodyDetailsDesktop({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case RegisterInitial:
            return Center(
              child: Text(
                'Aun no tienes ningun contacto...',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            );
          default:
            if (state.values.users.length > 0)
              return Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Mis Contactos',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 1000,
                      child: Table(
                        border: TableBorder.all(color: Colors.grey[350]),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        defaultColumnWidth: FixedColumnWidth(200),
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(2),
                          4: FlexColumnWidth(2),
                          5: FlexColumnWidth(2),
                        },
                        children: [
                          TableRow(
                            children: [
                              _CHeadTable(title: 'ID'),
                              _CHeadTable(title: 'NOMBRE'),
                              _CHeadTable(title: 'APELLIDO'),
                              _CHeadTable(title: 'TELEFONO'),
                              _CHeadTable(title: 'TIPO DE TEL.'),
                              _CHeadTable(title: ''),
                            ],
                          ),
                          for (int i = 0; i < state.values.users.length; i++)
                            TableRow(
                              children: [
                                _CBodyTable(
                                  title: '${state.values.users[i].id}',
                                  index: i,
                                  user: state.values.users[i],
                                ),
                                _CBodyTable(
                                    title: state.values.users[i].firstName,
                                    index: i,
                                    user: state.values.users[i]),
                                _CBodyTable(
                                    title: state.values.users[i].lastName,
                                    index: i,
                                    user: state.values.users[i]),
                                _CBodyTable(
                                    title: state.values.users[i].telefono,
                                    index: i,
                                    user: state.values.users[i]),
                                _CBodyTable(
                                    title: mapContactTypeToString[
                                        state.values.users[i].contactType],
                                    index: i,
                                    user: state.values.users[i]),
                                _CBodyTable(
                                    title: '',
                                    index: i,
                                    isToEdit: true,
                                    user: state.values.users[i])
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
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
    );
  }
}

class _CHeadTable extends StatelessWidget {
  const _CHeadTable({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Text(
        title ?? '',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _CBodyTable extends StatelessWidget {
  const _CBodyTable(
      {Key key,
      @required this.title,
      this.index = 0,
      this.isToEdit = false,
      @required this.user})
      : super(key: key);

  final User user;
  final String title;
  final int index;
  final bool isToEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index % 2 == 1 ? Colors.white : Colors.grey[200],
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: isToEdit ? 5 : 10, horizontal: 5),
      child: isToEdit
          ? Container(
              child: Row(
                children: [
                  CButtonDetails(
                    icon: Icons.edit,
                    title: 'Edit',
                    isBorderLeft: true,
                    onTap: () {
                      Navigator.pushNamed(
                          context, AddAndUpdateContactScreen.route,
                          arguments: user);
                    },
                  ),
                  CButtonDetails(
                    icon: Icons.delete_forever,
                    title: 'Trash',
                    isBorderLeft: false,
                    onTap: () {
                      context.bloc<RegisterCubit>().deleteUser(index);
                    },
                  ),
                ],
              ),
            )
          : Text(
              title ?? '',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
    );
  }
}

class CButtonDetails extends StatelessWidget {
  const CButtonDetails({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.isBorderLeft,
    @required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final bool isBorderLeft;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: isBorderLeft ? Colors.green : Colors.red,
            borderRadius: BorderRadius.horizontal(
              left: isBorderLeft ? Radius.circular(3) : Radius.circular(0),
              right: isBorderLeft ? Radius.circular(0) : Radius.circular(3),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon ?? Icons.edit_location,
                color: Colors.white,
              ),
              Text(
                title ?? '',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
