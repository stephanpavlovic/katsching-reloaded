class Repetition < ApplicationRecord
end

# == Schema Information
#
# Table name: repetitions
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  next_iteration :datetime
#  timing         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
