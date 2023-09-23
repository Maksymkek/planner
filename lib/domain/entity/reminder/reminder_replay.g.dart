// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_replay.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderRepeatAdapter extends TypeAdapter<ReminderRepeat> {
  @override
  final int typeId = 3;

  @override
  ReminderRepeat read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReminderRepeat.hour;
      case 1:
        return ReminderRepeat.day;
      case 2:
        return ReminderRepeat.month;
      case 3:
        return ReminderRepeat.year;
      case 4:
        return ReminderRepeat.never;
      default:
        return ReminderRepeat.hour;
    }
  }

  @override
  void write(BinaryWriter writer, ReminderRepeat obj) {
    switch (obj) {
      case ReminderRepeat.hour:
        writer.writeByte(0);
        break;
      case ReminderRepeat.day:
        writer.writeByte(1);
        break;
      case ReminderRepeat.month:
        writer.writeByte(2);
        break;
      case ReminderRepeat.year:
        writer.writeByte(3);
        break;
      case ReminderRepeat.never:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderRepeatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
