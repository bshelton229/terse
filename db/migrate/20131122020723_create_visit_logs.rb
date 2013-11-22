class CreateVisitLogs < ActiveRecord::Migration
  def change
    create_table :visit_logs do |t|
      t.references :url, index: true
      t.string :referer
      t.string :ip

      t.timestamps
    end
  end
end
