# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create 5 books
5.times do |i|
  Book.find_or_create_by!(
    title: "Sample Book #{i + 1}",
    author: "Author #{i + 1}"
  )
end
 # Create 2 readers
2.times do |i|
  Reader.find_or_create_by!(
    name: "Reader #{i + 1}",
    email: "reader#{i + 1}@example.com"
  )
end

# Create 3 borrowing record
BorrowingRecord.find_or_create_by!(
  book: Book.first,
  reader: Reader.first,
  borrowed_date: Date.today,
  due_date: Date.today + 30.days,
  return_date: nil
)

BorrowingRecord.find_or_create_by!(
  book: Book.second,
  reader: Reader.second,
  borrowed_date: Date.today,
  due_date: Date.today + 30.days,
  return_date: Date.today + 15.days
)

BorrowingRecord.find_or_create_by!(
  book: Book.third,
  reader: Reader.first,
  borrowed_date: Date.today - 35.days,
  due_date: Date.today - 5.days,
  return_date: nil
)
