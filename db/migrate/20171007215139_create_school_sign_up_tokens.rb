class CreateSchoolSignUpTokens < ActiveRecord::Migration
  def change
    create_table :school_sign_up_tokens do |t|
      t.string :token
      t.timestamp :expires_at

      t.timestamps null: false
    end
  end
end
