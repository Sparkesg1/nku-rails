class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.date    :attended_on
      t.integer :seat
      t.integer :student_id

      t.timestamps
    end
  end
end
