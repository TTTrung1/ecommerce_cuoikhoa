// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CartState {
  List<CartItem> get listItem => throw _privateConstructorUsedError;
  double get totalCost => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get clicked => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CartStateCopyWith<CartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartStateCopyWith<$Res> {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) then) =
      _$CartStateCopyWithImpl<$Res, CartState>;
  @useResult
  $Res call(
      {List<CartItem> listItem, double totalCost, bool loading, bool clicked});
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res, $Val extends CartState>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listItem = null,
    Object? totalCost = null,
    Object? loading = null,
    Object? clicked = null,
  }) {
    return _then(_value.copyWith(
      listItem: null == listItem
          ? _value.listItem
          : listItem // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      clicked: null == clicked
          ? _value.clicked
          : clicked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartStateImplCopyWith<$Res>
    implements $CartStateCopyWith<$Res> {
  factory _$$CartStateImplCopyWith(
          _$CartStateImpl value, $Res Function(_$CartStateImpl) then) =
      __$$CartStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CartItem> listItem, double totalCost, bool loading, bool clicked});
}

/// @nodoc
class __$$CartStateImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartStateImpl>
    implements _$$CartStateImplCopyWith<$Res> {
  __$$CartStateImplCopyWithImpl(
      _$CartStateImpl _value, $Res Function(_$CartStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listItem = null,
    Object? totalCost = null,
    Object? loading = null,
    Object? clicked = null,
  }) {
    return _then(_$CartStateImpl(
      listItem: null == listItem
          ? _value._listItem
          : listItem // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      clicked: null == clicked
          ? _value.clicked
          : clicked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CartStateImpl implements _CartState {
  const _$CartStateImpl(
      {final List<CartItem> listItem = const [],
      this.totalCost = 0,
      this.loading = false,
      this.clicked = false})
      : _listItem = listItem;

  final List<CartItem> _listItem;
  @override
  @JsonKey()
  List<CartItem> get listItem {
    if (_listItem is EqualUnmodifiableListView) return _listItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listItem);
  }

  @override
  @JsonKey()
  final double totalCost;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool clicked;

  @override
  String toString() {
    return 'CartState(listItem: $listItem, totalCost: $totalCost, loading: $loading, clicked: $clicked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartStateImpl &&
            const DeepCollectionEquality().equals(other._listItem, _listItem) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.clicked, clicked) || other.clicked == clicked));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_listItem),
      totalCost,
      loading,
      clicked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartStateImplCopyWith<_$CartStateImpl> get copyWith =>
      __$$CartStateImplCopyWithImpl<_$CartStateImpl>(this, _$identity);
}

abstract class _CartState implements CartState {
  const factory _CartState(
      {final List<CartItem> listItem,
      final double totalCost,
      final bool loading,
      final bool clicked}) = _$CartStateImpl;

  @override
  List<CartItem> get listItem;
  @override
  double get totalCost;
  @override
  bool get loading;
  @override
  bool get clicked;
  @override
  @JsonKey(ignore: true)
  _$$CartStateImplCopyWith<_$CartStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
