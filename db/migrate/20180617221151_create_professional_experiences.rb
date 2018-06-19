class CreateProfessionalExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :professional_experiences do |t|
      t.string :company_name, nullable: false
      t.string :role, nullable: false
      t.date :start_date, nullable: false
      t.date :end_date, nullable: false

      t.references :curriculum, foreign_key: true, nullable: false

      t.timestamps
    end
  end
end
