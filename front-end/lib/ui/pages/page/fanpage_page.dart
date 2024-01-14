import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:thien_nguyen_app/models/entity/fanpage.dart';
import 'package:thien_nguyen_app/repositories/server/fanpage_provider.dart';
import 'package:thien_nguyen_app/singleton/current_info.dart';
import 'package:thien_nguyen_app/ui/theme/theme.dart';
import 'package:thien_nguyen_app/ui/widgets/fanpage_choice.dart';
import 'package:thien_nguyen_app/utilities/bloc/fanpage_list_bloc.dart';

part 'fanpage_page_appbar.dart';

class FanpagePage extends StatefulWidget {
  @override
  State<FanpagePage> createState() => _FanpagePageState();
}

class _FanpagePageState extends State<FanpagePage> {
  GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey();
  final _bloc = FanpageListBloc(null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _bloc,
        lazy: false,
        child: FutureBuilder(
            future: FanpageServerRepository.getAllFanpage(CurrentInfo.user!.id!), builder: (context, snapshot) {
          if (snapshot.hasData) {
            _bloc.emit(snapshot.requireData);
            return RefreshIndicator(
                key: _refreshKey,
                onRefresh: _refresh,
            child: FanpageBody());
          }
          else if (snapshot.hasError) {
            return Container();
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
    );
  }

  Future<void> _refresh() async {
    final fanpages = await FanpageServerRepository.getAllFanpage(CurrentInfo.user!.id!);
    setState(() {
      _bloc.emit(fanpages);
    });
  }
}

class FanpageBody extends StatefulWidget {
  const FanpageBody({super.key});

  @override
  State<FanpageBody> createState() => _FanpageBodyState();
}

class _FanpageBodyState extends State<FanpageBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        FanpagePageAppBar(),
        BlocConsumer(
            bloc: context.read<FanpageListBloc>(),
            listener: (context, state) => setState(() {}),
            builder: (context, state) {
              List fanpages = state as List<Fanpage>;
              return SliverList.list(
                  children: fanpages.map((e) => FanpageChoice(fanpage: e, delete: _delete(context, e),)).toList());
            }
          ),
      ],
    );
  }

  _delete(BuildContext context, Fanpage fanpage) {
    return () async {
      Fanpage? result = await showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("Xoá ${fanpage.fanpageName ?? "fanpage không xác định"}"),
        content: Text("Bạn có chắc muốn xóa fanpage ${fanpage.fanpageName ?? "fanpage không xác định"}"),
        actions: [
          TextButton(onPressed: () async {
            try {
              await FanpageServerRepository.deleteFanpage(fanpage.id!);
            }
            catch (e) {
              print(e);
            }
            finally {
              if (context.mounted) context.pop(fanpage);
            }
          }, child: Text("Xóa", style: TextStyle(color: Colors.redAccent))),
          TextButton(onPressed: () => context.pop(), child: Text("Thoát")),
        ],
      ));
      if (result != null && context.mounted) {
        context.read<FanpageListBloc>().removeFanpage(result);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã xóa fanpage ${result.fanpageName}")));
      }
    };
  }
}
