// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FolderDataModelAdapter extends TypeAdapter<FolderDataModel> {
  @override
  final int typeId = 0;

  @override
  FolderDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FolderDataModel(
      id: fields[0] as String,
      title: fields[1] as String,
      background: fields[2] as int,
      icon: fields[3] as int,
      reminders: (fields[6] as List).cast<ReminderLink>(),
      iconPackage: fields[4] as String?,
      iconFamily: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FolderDataModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.background)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.iconPackage)
      ..writeByte(5)
      ..write(obj.iconFamily)
      ..writeByte(6)
      ..write(obj.reminders);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FolderDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
