class CreateParts < ActiveRecord::Migration[6.1]
  def change
    create_table :parts do |t|
      t.references :design, null: false, foreign_key: true
      t.string  :name, null: false
      t.string  :size
      t.integer  :quantity, null: false
      t.string  :hex_number

      t.timestamps
    end
  end
end
