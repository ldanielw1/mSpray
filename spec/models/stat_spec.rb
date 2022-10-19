require 'rails_helper'

RSpec.describe(Stat, type: :model) do

  describe 'Stat creation' do

    it 'works even without inputs' do
      stat_count = Stat.count
      Stat.create
      expect(Stat.count).to eql(stat_count + 1)
    end

  end

end
