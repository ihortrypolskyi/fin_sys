class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.float :sum
      t.text :description
      t.date :date
      t.string :debtor
      t.referances :loan
      t.array :state
      t.datetime :paid_at

      t.timestamps
    end
  end
end
