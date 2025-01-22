import 'package:ecommerce2/app/dependency_injection.dart';
import 'package:ecommerce2/app/features/auth/service/auth_service.dart';
import 'package:ecommerce2/app/features/product/data/model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final AuthService _authService = getIt();
  CheckoutBloc() : super(CheckoutState()) {
    on<CheckoutEventCheckout>(_onClickCheckoutButton);
  }

  Future<void> _onClickCheckoutButton(CheckoutEventCheckout event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
     final bool  isAuthenticated = await _authService.isAuthenticated();
     if(!isAuthenticated){
       emit(state.copyWith(status: Status.error, errorMsg: 'Please login to complete your purchase'));
     }else{
       emit(state.copyWith(status: Status.success));
     }
    } catch (e) {
      emit(state.copyWith(errorMsg: e.toString(), status: Status.error));
    }
  }
}
