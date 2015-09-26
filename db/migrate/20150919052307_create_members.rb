class CreateMembers < ActiveRecord::Migration
  def up
    create_table :members do |t|
	t.string "email", :uniquness => true, :null=> "false"
	t.string "name"
	t.string "password"
        t.timestamps 
    end
  end
	def down
		drop_table :members
	end
end
