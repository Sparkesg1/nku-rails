class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :fname
      t.string :lname
      t.string :nname
      t.string :email

      t.timestamps
    end
  end
end
