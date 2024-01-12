# frozen_string_literal: true

module Replicate
  class Client
    # Methods for the Prediction API
    module DreamboothTraining
      # Get a training
      # @see https://replicate.com/blog/dreambooth-api
      def retrieve_dreambooth_training(id)
        response = dreambooth_endpoint.get("trainings/#{id}")
        Replicate::Record::DreamboothTraining.new(self, response)
      end

      # Create a training
      # @see https://replicate.com/blog/dreambooth-api
      def create_dreambooth_training(params)
        params[:webhook] ||= webhook_url
        response = dreambooth_endpoint.post("trainings", params)
        Replicate::Record::DreamboothTraining.new(self, response)
      end

      def dreambooth_endpoint
        @dreambooth_endpoint ||= Replicate::Endpoint.new(
          endpoint_url: dreambooth_endpoint_url,
          api_token: api_token
        )
      end
    end
  end
end
