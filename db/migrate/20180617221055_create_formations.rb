class CreateFormations < ActiveRecord::Migration[5.2]
  def change
    create_table :formations do |t|
      t.string :institution, nullable: false
      t.string :course, nullable: false
      t.boolean :concluded, nullable: false
      t.date :start_date, nullable: false
      t.date :end_date, nullable: false

      t.references :curriculum, foreign_key: true, nullable: false

      t.timestamps
    end
  end
end
