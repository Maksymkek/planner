abstract base class Repository<Item> {
  Future<List<Item>> getItems();

  Future<void> createItem(Item item);

  Future<void> updateItem(Item item);

  Future<void> deleteItem(Item item);
}
