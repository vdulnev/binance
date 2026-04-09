// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symbol_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SymbolFilter _$SymbolFilterFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'PRICE_FILTER':
          return PriceFilter.fromJson(
            json
          );
                case 'LOT_SIZE':
          return LotSize.fromJson(
            json
          );
                case 'MIN_NOTIONAL':
          return MinNotional.fromJson(
            json
          );
                case 'other':
          return SymbolFilterOther.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'SymbolFilter',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$SymbolFilter {



  /// Serializes this SymbolFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymbolFilter);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SymbolFilter()';
}


}

/// @nodoc
class $SymbolFilterCopyWith<$Res>  {
$SymbolFilterCopyWith(SymbolFilter _, $Res Function(SymbolFilter) __);
}


/// Adds pattern-matching-related methods to [SymbolFilter].
extension SymbolFilterPatterns on SymbolFilter {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PriceFilter value)?  priceFilter,TResult Function( LotSize value)?  lotSize,TResult Function( MinNotional value)?  minNotional,TResult Function( SymbolFilterOther value)?  other,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PriceFilter() when priceFilter != null:
return priceFilter(_that);case LotSize() when lotSize != null:
return lotSize(_that);case MinNotional() when minNotional != null:
return minNotional(_that);case SymbolFilterOther() when other != null:
return other(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PriceFilter value)  priceFilter,required TResult Function( LotSize value)  lotSize,required TResult Function( MinNotional value)  minNotional,required TResult Function( SymbolFilterOther value)  other,}){
final _that = this;
switch (_that) {
case PriceFilter():
return priceFilter(_that);case LotSize():
return lotSize(_that);case MinNotional():
return minNotional(_that);case SymbolFilterOther():
return other(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PriceFilter value)?  priceFilter,TResult? Function( LotSize value)?  lotSize,TResult? Function( MinNotional value)?  minNotional,TResult? Function( SymbolFilterOther value)?  other,}){
final _that = this;
switch (_that) {
case PriceFilter() when priceFilter != null:
return priceFilter(_that);case LotSize() when lotSize != null:
return lotSize(_that);case MinNotional() when minNotional != null:
return minNotional(_that);case SymbolFilterOther() when other != null:
return other(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@DecimalConverter()  Decimal minPrice, @DecimalConverter()  Decimal maxPrice, @DecimalConverter()  Decimal tickSize)?  priceFilter,TResult Function(@DecimalConverter()  Decimal minQty, @DecimalConverter()  Decimal maxQty, @DecimalConverter()  Decimal stepSize)?  lotSize,TResult Function(@DecimalConverter()  Decimal minNotional)?  minNotional,TResult Function( String filterType,  Map<String, dynamic> raw)?  other,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PriceFilter() when priceFilter != null:
return priceFilter(_that.minPrice,_that.maxPrice,_that.tickSize);case LotSize() when lotSize != null:
return lotSize(_that.minQty,_that.maxQty,_that.stepSize);case MinNotional() when minNotional != null:
return minNotional(_that.minNotional);case SymbolFilterOther() when other != null:
return other(_that.filterType,_that.raw);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@DecimalConverter()  Decimal minPrice, @DecimalConverter()  Decimal maxPrice, @DecimalConverter()  Decimal tickSize)  priceFilter,required TResult Function(@DecimalConverter()  Decimal minQty, @DecimalConverter()  Decimal maxQty, @DecimalConverter()  Decimal stepSize)  lotSize,required TResult Function(@DecimalConverter()  Decimal minNotional)  minNotional,required TResult Function( String filterType,  Map<String, dynamic> raw)  other,}) {final _that = this;
switch (_that) {
case PriceFilter():
return priceFilter(_that.minPrice,_that.maxPrice,_that.tickSize);case LotSize():
return lotSize(_that.minQty,_that.maxQty,_that.stepSize);case MinNotional():
return minNotional(_that.minNotional);case SymbolFilterOther():
return other(_that.filterType,_that.raw);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@DecimalConverter()  Decimal minPrice, @DecimalConverter()  Decimal maxPrice, @DecimalConverter()  Decimal tickSize)?  priceFilter,TResult? Function(@DecimalConverter()  Decimal minQty, @DecimalConverter()  Decimal maxQty, @DecimalConverter()  Decimal stepSize)?  lotSize,TResult? Function(@DecimalConverter()  Decimal minNotional)?  minNotional,TResult? Function( String filterType,  Map<String, dynamic> raw)?  other,}) {final _that = this;
switch (_that) {
case PriceFilter() when priceFilter != null:
return priceFilter(_that.minPrice,_that.maxPrice,_that.tickSize);case LotSize() when lotSize != null:
return lotSize(_that.minQty,_that.maxQty,_that.stepSize);case MinNotional() when minNotional != null:
return minNotional(_that.minNotional);case SymbolFilterOther() when other != null:
return other(_that.filterType,_that.raw);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PriceFilter extends SymbolFilter {
  const PriceFilter({@DecimalConverter() required this.minPrice, @DecimalConverter() required this.maxPrice, @DecimalConverter() required this.tickSize, final  String? $type}): $type = $type ?? 'PRICE_FILTER',super._();
  factory PriceFilter.fromJson(Map<String, dynamic> json) => _$PriceFilterFromJson(json);

@DecimalConverter() final  Decimal minPrice;
@DecimalConverter() final  Decimal maxPrice;
@DecimalConverter() final  Decimal tickSize;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SymbolFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceFilterCopyWith<PriceFilter> get copyWith => _$PriceFilterCopyWithImpl<PriceFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PriceFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceFilter&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.tickSize, tickSize) || other.tickSize == tickSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minPrice,maxPrice,tickSize);

@override
String toString() {
  return 'SymbolFilter.priceFilter(minPrice: $minPrice, maxPrice: $maxPrice, tickSize: $tickSize)';
}


}

/// @nodoc
abstract mixin class $PriceFilterCopyWith<$Res> implements $SymbolFilterCopyWith<$Res> {
  factory $PriceFilterCopyWith(PriceFilter value, $Res Function(PriceFilter) _then) = _$PriceFilterCopyWithImpl;
@useResult
$Res call({
@DecimalConverter() Decimal minPrice,@DecimalConverter() Decimal maxPrice,@DecimalConverter() Decimal tickSize
});




}
/// @nodoc
class _$PriceFilterCopyWithImpl<$Res>
    implements $PriceFilterCopyWith<$Res> {
  _$PriceFilterCopyWithImpl(this._self, this._then);

  final PriceFilter _self;
  final $Res Function(PriceFilter) _then;

/// Create a copy of SymbolFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? minPrice = null,Object? maxPrice = null,Object? tickSize = null,}) {
  return _then(PriceFilter(
minPrice: null == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as Decimal,maxPrice: null == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as Decimal,tickSize: null == tickSize ? _self.tickSize : tickSize // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LotSize extends SymbolFilter {
  const LotSize({@DecimalConverter() required this.minQty, @DecimalConverter() required this.maxQty, @DecimalConverter() required this.stepSize, final  String? $type}): $type = $type ?? 'LOT_SIZE',super._();
  factory LotSize.fromJson(Map<String, dynamic> json) => _$LotSizeFromJson(json);

@DecimalConverter() final  Decimal minQty;
@DecimalConverter() final  Decimal maxQty;
@DecimalConverter() final  Decimal stepSize;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SymbolFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LotSizeCopyWith<LotSize> get copyWith => _$LotSizeCopyWithImpl<LotSize>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LotSizeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LotSize&&(identical(other.minQty, minQty) || other.minQty == minQty)&&(identical(other.maxQty, maxQty) || other.maxQty == maxQty)&&(identical(other.stepSize, stepSize) || other.stepSize == stepSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minQty,maxQty,stepSize);

@override
String toString() {
  return 'SymbolFilter.lotSize(minQty: $minQty, maxQty: $maxQty, stepSize: $stepSize)';
}


}

/// @nodoc
abstract mixin class $LotSizeCopyWith<$Res> implements $SymbolFilterCopyWith<$Res> {
  factory $LotSizeCopyWith(LotSize value, $Res Function(LotSize) _then) = _$LotSizeCopyWithImpl;
@useResult
$Res call({
@DecimalConverter() Decimal minQty,@DecimalConverter() Decimal maxQty,@DecimalConverter() Decimal stepSize
});




}
/// @nodoc
class _$LotSizeCopyWithImpl<$Res>
    implements $LotSizeCopyWith<$Res> {
  _$LotSizeCopyWithImpl(this._self, this._then);

  final LotSize _self;
  final $Res Function(LotSize) _then;

/// Create a copy of SymbolFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? minQty = null,Object? maxQty = null,Object? stepSize = null,}) {
  return _then(LotSize(
minQty: null == minQty ? _self.minQty : minQty // ignore: cast_nullable_to_non_nullable
as Decimal,maxQty: null == maxQty ? _self.maxQty : maxQty // ignore: cast_nullable_to_non_nullable
as Decimal,stepSize: null == stepSize ? _self.stepSize : stepSize // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}


}

/// @nodoc
@JsonSerializable()

class MinNotional extends SymbolFilter {
  const MinNotional({@DecimalConverter() required this.minNotional, final  String? $type}): $type = $type ?? 'MIN_NOTIONAL',super._();
  factory MinNotional.fromJson(Map<String, dynamic> json) => _$MinNotionalFromJson(json);

@DecimalConverter() final  Decimal minNotional;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SymbolFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MinNotionalCopyWith<MinNotional> get copyWith => _$MinNotionalCopyWithImpl<MinNotional>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MinNotionalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MinNotional&&(identical(other.minNotional, minNotional) || other.minNotional == minNotional));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minNotional);

@override
String toString() {
  return 'SymbolFilter.minNotional(minNotional: $minNotional)';
}


}

/// @nodoc
abstract mixin class $MinNotionalCopyWith<$Res> implements $SymbolFilterCopyWith<$Res> {
  factory $MinNotionalCopyWith(MinNotional value, $Res Function(MinNotional) _then) = _$MinNotionalCopyWithImpl;
@useResult
$Res call({
@DecimalConverter() Decimal minNotional
});




}
/// @nodoc
class _$MinNotionalCopyWithImpl<$Res>
    implements $MinNotionalCopyWith<$Res> {
  _$MinNotionalCopyWithImpl(this._self, this._then);

  final MinNotional _self;
  final $Res Function(MinNotional) _then;

/// Create a copy of SymbolFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? minNotional = null,}) {
  return _then(MinNotional(
minNotional: null == minNotional ? _self.minNotional : minNotional // ignore: cast_nullable_to_non_nullable
as Decimal,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SymbolFilterOther extends SymbolFilter {
  const SymbolFilterOther({required this.filterType, final  Map<String, dynamic> raw = const <String, dynamic>{}, final  String? $type}): _raw = raw,$type = $type ?? 'other',super._();
  factory SymbolFilterOther.fromJson(Map<String, dynamic> json) => _$SymbolFilterOtherFromJson(json);

 final  String filterType;
 final  Map<String, dynamic> _raw;
@JsonKey() Map<String, dynamic> get raw {
  if (_raw is EqualUnmodifiableMapView) return _raw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_raw);
}


@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SymbolFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SymbolFilterOtherCopyWith<SymbolFilterOther> get copyWith => _$SymbolFilterOtherCopyWithImpl<SymbolFilterOther>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SymbolFilterOtherToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SymbolFilterOther&&(identical(other.filterType, filterType) || other.filterType == filterType)&&const DeepCollectionEquality().equals(other._raw, _raw));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filterType,const DeepCollectionEquality().hash(_raw));

@override
String toString() {
  return 'SymbolFilter.other(filterType: $filterType, raw: $raw)';
}


}

/// @nodoc
abstract mixin class $SymbolFilterOtherCopyWith<$Res> implements $SymbolFilterCopyWith<$Res> {
  factory $SymbolFilterOtherCopyWith(SymbolFilterOther value, $Res Function(SymbolFilterOther) _then) = _$SymbolFilterOtherCopyWithImpl;
@useResult
$Res call({
 String filterType, Map<String, dynamic> raw
});




}
/// @nodoc
class _$SymbolFilterOtherCopyWithImpl<$Res>
    implements $SymbolFilterOtherCopyWith<$Res> {
  _$SymbolFilterOtherCopyWithImpl(this._self, this._then);

  final SymbolFilterOther _self;
  final $Res Function(SymbolFilterOther) _then;

/// Create a copy of SymbolFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filterType = null,Object? raw = null,}) {
  return _then(SymbolFilterOther(
filterType: null == filterType ? _self.filterType : filterType // ignore: cast_nullable_to_non_nullable
as String,raw: null == raw ? _self._raw : raw // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
