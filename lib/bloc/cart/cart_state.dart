part of 'cart_bloc.dart';

// @immutable
//  class CartState {
//    List<CartItem> listItem=[];
//    double totalCost=0;
// }
//
// class CartInitial extends CartState {}
//
// class CartLoading extends CartState {}
//
// class CartLoadSuccessState extends CartState {
// }
//
// class CartActionState extends CartState {}
//
//
// class CartAddSuccessState extends CartActionState {}
//
//
// class CartRemoveSuccessState extends CartActionState {}
//
//
// class CartDeleteSuccessState extends CartActionState {}
//
// class CartErrorState extends CartState {}


@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default([]) List<CartItem> listItem,
    @Default(0) double totalCost,
    @Default(false) bool loading,
    @Default(false) bool clicked
}) = _CartState;

}