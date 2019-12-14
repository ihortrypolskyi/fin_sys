class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.float :sum, null: false
      t.text :description
      t.date :pay_until
      t.integer :state, null: false, default: 0
      t.datetime :paid_at
      t.references :loan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
