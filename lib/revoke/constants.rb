module Revoke
  module Constants
    ACTION = %i[update delete].freeze
    EVENT = {
      after: '>'
    }.freeze
    ACTION_MAP = {
      creation: 'created_at',
      updation: 'updated_at',
      deletion: 'deleted_at'
    }.freeze
  end
end
