class CreateDebtors < ActiveRecord::Migration[6.0]
  def change
    create_table :debtors do |t|

      t.timestamps
    end
  end
end
