class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :name
      t.string :status
      t.integer :agent_id
    end
  end
end
