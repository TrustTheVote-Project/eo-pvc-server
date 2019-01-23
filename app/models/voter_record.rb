require 'csv'
class VoterRecord < ApplicationRecord
  def self.init!
    # Reload all from CSV
    VoterRecord.delete_all
    CSV.read(Rails.root.join("db/data/voter-records.csv"), headers: true).each do |row|
      VoterRecord.create(row.to_hash)
    end
  end
  
end
