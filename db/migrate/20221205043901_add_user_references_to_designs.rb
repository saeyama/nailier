class AddUserReferencesToDesigns < ActiveRecord::Migration[6.1]
  def change
    add_reference :designs, :user, null: false, foreign_key: true    
  end
end
