class CreateSqlInjectionObjects < ActiveRecord::Migration
  def change
    create_table :sql_injection_objects do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
