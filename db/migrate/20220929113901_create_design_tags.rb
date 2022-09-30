class CreateDesignTags < ActiveRecord::Migration[6.1]
  def change
    create_table :design_tags do |t|
      t.references :design, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
