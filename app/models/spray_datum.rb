class SprayDatum < ApplicationRecord
  # Add intialize, save, and delete hooks
  after_initialize { |new_user| init_actions(new_user) }

  ##
  # Populate data fields for new SprayDatum object when initialized
  def init_actions(new_spray_datum)
    new_spray_datum ||= Time.current.to_s.split(" ")[0..1].join(" ")
  end

end
