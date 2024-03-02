module Statuses
  extend ActiveSupport::Concern

  STATUS_LIST = { pending: 'pending',
                  booting: 'booting',
                  ongoing: 'ongoing',
                  paused: 'paused',
                  blocked: 'blocked',
                  finished: 'finished',
                  closed: 'closed',
                  abandoned: 'abandoned' }
  
  included do
    enum :status, STATUS_LIST, prefix: true, scopes: true,
         validate: true, default: :pending

  end

  class_methods do
  end
  
end
