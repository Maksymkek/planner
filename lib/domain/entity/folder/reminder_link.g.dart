// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_link.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderLinkAdapter extends TypeAdapter<ReminderLink> {
  @override
  final int typeId = 2;

  @override
  ReminderLink read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderLink(
      fields[0] as String,
      fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderLink obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderLinkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
