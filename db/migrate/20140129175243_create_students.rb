class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :nick_name
      t.string :email
      t.string :password_digest
      t.boolean  :is_admin

      t.timestamps
    end
  end
end
