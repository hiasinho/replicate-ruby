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
        params[:webhook] ||= webhook_url
        model_owner, model_name, version_id = params[:version].split(/[\/:]/)

        response = api_endpoint.post(
          "models/#{model_owner}/#{model_name}/versions/#{version_id}/trainings",
          params
        )
        Replicate::Record::Training.new(self, response)
      end
    end
  end
end
