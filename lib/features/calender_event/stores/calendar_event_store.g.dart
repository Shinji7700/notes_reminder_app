// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CalendarEventStore on _CalendarEventStore, Store {
  final _$fromDateAtom = Atom(name: '_CalendarEventStore.fromDate');

  @override
  DateTime? get fromDate {
    _$fromDateAtom.reportRead();
    return super.fromDate;
  }

  @override
  set fromDate(DateTime? value) {
    _$fromDateAtom.reportWrite(value, super.fromDate, () {
      super.fromDate = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_CalendarEventStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isDataLoadingAtom = Atom(name: '_CalendarEventStore.isDataLoading');

  @override
  bool get isDataLoading {
    _$isDataLoadingAtom.reportRead();
    return super.isDataLoading;
  }

  @override
  set isDataLoading(bool value) {
    _$isDataLoadingAtom.reportWrite(value, super.isDataLoading, () {
      super.isDataLoading = value;
    });
  }

  final _$calendarTapDetailsAtom =
      Atom(name: '_CalendarEventStore.calendarTapDetails');

  @override
  CalendarTapDetails get calendarTapDetails {
    _$calendarTapDetailsAtom.reportRead();
    return super.calendarTapDetails;
  }

  @override
  set calendarTapDetails(CalendarTapDetails value) {
    _$calendarTapDetailsAtom.reportWrite(value, super.calendarTapDetails, () {
      super.calendarTapDetails = value;
    });
  }

  final _$_CalendarEventStoreActionController =
      ActionController(name: '_CalendarEventStore');

  @override
  void calendarTapped(CalendarTapDetails tapDetails) {
    final _$actionInfo = _$_CalendarEventStoreActionController.startAction(
        name: '_CalendarEventStore.calendarTapped');
    try {
      return super.calendarTapped(tapDetails);
    } finally {
      _$_CalendarEventStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addEvent() {
    final _$actionInfo = _$_CalendarEventStoreActionController.startAction(
        name: '_CalendarEventStore.addEvent');
    try {
      return super.addEvent();
    } finally {
      _$_CalendarEventStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fromDate: ${fromDate},
isLoading: ${isLoading},
isDataLoading: ${isDataLoading},
calendarTapDetails: ${calendarTapDetails}
    ''';
  }
}
