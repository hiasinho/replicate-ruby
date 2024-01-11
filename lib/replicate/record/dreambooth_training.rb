# frozen_string_literal: true

module Replicate
  module Record
    class DreamboothTraining < Base
      def refetch
        @data = client.retrieve_dreambooth_training(id).data
      end
    end
  end
end
