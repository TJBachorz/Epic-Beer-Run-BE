class Brewery < ApplicationRecord
    scope :filter_by_state, -> (state) { where state: state }
end
