class LocationSerializer < ApplicationSerializer
  attributes :id, :location
  belongs_to :company
end
