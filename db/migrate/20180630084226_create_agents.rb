class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :name
      t.string :password_digest
      t.integer :region_id
    end
  end
end
