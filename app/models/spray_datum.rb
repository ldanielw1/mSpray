class SprayDatum < ApplicationRecord
  # Make sure that lists can be serialized as strings in the Rails DB
  serialize :sprayers
  serialize :stats

  # Add intialize, save, and delete hooks
  after_initialize { |new_sd| init_actions(new_sd) }

  ##
  # Populate data fields for new SprayDatum object when initialized
  def init_actions(new_sd)
    # Make sure sprayers is properly loaded from yaml
    new_sd.sprayers ||= []
    sprayers_attr = new_sd.sprayers
    new_sd.sprayers = YAML.load(sprayers_attr) if sprayers_attr.class == String

    # Make sure stats is properly loaded from yaml
    new_sd.stats ||= {}
    stats_attr = new_sd.stats
    new_sd.stats = YAML.load(stats_attr) if stats_attr.class == String

    # Make sure timestamp exists
    new_sd.timestamp ||= Time.current.to_s.split(" ")[0..1].join(" ")
  end

end
