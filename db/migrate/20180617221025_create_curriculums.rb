class CreateCurriculums < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculums do |t|
      t.boolean :active, nullable: false
      t.string :picture, nullable: false
      t.date :birthdate, nullable: false
      t.string :name, nullable: false
      t.string :gender, nullable: false
      t.string :email, nullable: false
      t.string :phone, nullable: false
      t.string :address, nullable: false
      t.decimal :latitude, nullable: false
      t.decimal :longitude, nullable: false
      t.string :tags, nullable: true
      t.decimal :score, default: 0

      t.timestamps
    end
  end
end
