class CreateLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :loans do |t|
      t.float :sum
      t.integer :percentage
      t.array :type
      t.integer :number_of_month
      t.float :static_return_value
      t.float :payed_sum

      t.timestamps
    end
  end
end
