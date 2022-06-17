// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bug_reproduction/counter/counter.dart';
import 'package:bug_reproduction/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({required this.initialValue, super.key});

  final int initialValue;

  @override
  Widget build(BuildContext context) {
    print('counter page value : $initialValue');
    return BlocProvider(
      create: (_) =>
          CounterCubit(intialValue: initialValue)..load(initialValue),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.select((CounterCubit cubit) => cubit.state);
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: const Center(child: CounterText()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              //? when we only go to the count+1 route the state is not updating
              context.go('/counter/${count + 1}');
              //? we need to uncomment the below line for the state to update as well
              //? this seems counter intutive as the state should only depend on the route and not on how I manage the state afterwards
              // context.read<CounterCubit>().load(count + 1);
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () {
              context.go('/counter/${count - 1}');
              //? same applies to this as well where we need to update the state manually rather than it updating itself from route
              // context.read<CounterCubit>().load(count - 1);
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text('$count', style: theme.textTheme.headline1);
  }
}
