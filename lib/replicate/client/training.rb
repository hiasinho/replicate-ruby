# frozen_string_literal: true

module Replicate
  class Client
    # Methods for the Prediction API
    module Training
      def retrieve_training(id)
        response = api_endpoint.get("trainings/#{id}")
        Replicate::Record::Training.new(self, response)
      end

      # Create a training v2
      # @see https://replicate.com/stability-ai/sdxl/train
      def create_training(params)
        input = params[:input]
        destination = params[:destination]
        model_owner, model_name, version_id = params[:version].split(/[\/:]/)
        url = "models/#{model_owner}/#{model_name}/versions/#{version_id}/trainings"

        response = api_endpoint.post(
          url,
          {
            destination: destination,
            input: input
          }
        )
        Replicate::Record::Training.new(self, response)
      end
    end
  end
end
