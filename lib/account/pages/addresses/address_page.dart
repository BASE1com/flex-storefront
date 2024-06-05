import 'package:auto_route/auto_route.dart';
import 'package:flex_storefront/account/cubits/address_cubit.dart';
import 'package:flex_storefront/account/cubits/address_state.dart';
import 'package:flex_storefront/account/widgets/address_card.dart';
import 'package:flex_storefront/flex_ui/components/app_bar.dart';
import 'package:flex_storefront/flex_ui/tokens/sizes.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit()..loadAddresses(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.router.pushNamed('/address/new');
          },
          child: const Icon(Icons.add),
        ),
        appBar: const FlexAppBar(
          title: Text('Addresses'),
          showBackArrow: true,
          showSearchButton: false,
        ),
        body: const AddressView(),
      ),
    );
  }
}

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        if (state.status == Status.pending) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(FlexSizes.appPadding),
            child: Column(
              children:
                  state.addresses.map((a) => AddressCard(address: a)).toList(),
            ),
          ),
        );
      },
    );
  }
}
