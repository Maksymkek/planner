abstract base class Repository<Item> {
  Future<List<Item>> getItems();

  Future<void> createItem(Item item);

  Future<void> updateItem(Item item);

  Future<void> deleteItem(String id);

  Future<Item?> getItem(String id);

  Future<void> close();
}
