// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteEventModelAdapter extends TypeAdapter<NoteEventModel> {
  @override
  final int typeId = 0;

  @override
  NoteEventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteEventModel()
      ..noteTitle = fields[0] as String
      ..noteDesc = fields[1] as String
      ..eventDate = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, NoteEventModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.noteTitle)
      ..writeByte(1)
      ..write(obj.noteDesc)
      ..writeByte(2)
      ..write(obj.eventDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteEventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
