# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:authors_books) do
      foreign_key :author_id, :authors, null: false
      foreign_key :book_id, :books, null: false
      primary_key %i[author_id book_id]
      index %i[author_id book_id]
    end
  end
end
