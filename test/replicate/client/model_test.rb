# frozen_string_literal: true

require "test_helper"

class Replicate::Client::ModelTest < MiniTest::Test
  def test_retrieve_model_with_latest_version
    response = {"url"=>"https://replicate.com/stability-ai/stable-diffusion", "owner"=>"stability-ai", "name"=>"stable-diffusion", "description"=>"A latent text-to-image diffusion model capable of generating photo-realistic images given any text input", "visibility"=>"public", "github_url"=>"https://github.com/replicate/cog-stable-diffusion", "paper_url"=>"https://arxiv.org/abs/2112.10752", "license_url"=>"https://huggingface.co/spaces/CompVis/stable-diffusion-license", "latest_version"=>{"id"=>"a9758cbfbd5f3c2094457d996681af52552901775aa2d6dd0b17fd15df959bef", "created_at"=>"2022-08-31T21:06:15.330778Z", "cog_version"=>"0.4.2", "openapi_schema"=>{"info"=>{"title"=>"Cog", "version"=>"0.1.0"}, "paths"=>{"/"=>{"get"=>{"summary"=>"Root", "responses"=>{"200"=>{"content"=>{"application/json"=>{"schema"=>{}}}, "description"=>"Successful Response"}}, "operationId"=>"root__get"}}, "/predictions"=>{"post"=>{"summary"=>"Predict", "responses"=>{"200"=>{"content"=>{"application/json"=>{"schema"=>{"$ref"=>"#/components/schemas/Response"}}}, "description"=>"Successful Response"}, "422"=>{"content"=>{"application/json"=>{"schema"=>{"$ref"=>"#/components/schemas/HTTPValidationError"}}}, "description"=>"Validation Error"}}, "description"=>"Run a single prediction on the model", "operationId"=>"predict_predictions_post", "requestBody"=>{"content"=>{"application/json"=>{"schema"=>{"$ref"=>"#/components/schemas/Request"}}}}}}}, "openapi"=>"3.0.2", "components"=>{"schemas"=>{"Input"=>{"type"=>"object", "title"=>"Input", "properties"=>{"mask"=>{"type"=>"string", "title"=>"Mask", "format"=>"uri", "x-order"=>4, "description"=>"Black and white image to use as mask for inpainting over init_image. Black pixels are inpainted and white pixels are preserved. Experimental feature, tends to work better with prompt strength of 0.5-0.7"}, "seed"=>{"type"=>"integer", "title"=>"Seed", "x-order"=>9, "description"=>"Random seed. Leave blank to randomize the seed"}, "width"=>{"allOf"=>[{"$ref"=>"#/components/schemas/width"}], "default"=>512, "x-order"=>1, "description"=>"Width of output image. Maximum size is 1024x768 or 768x1024 because of memory limits"}, "height"=>{"allOf"=>[{"$ref"=>"#/components/schemas/height"}], "default"=>512, "x-order"=>2, "description"=>"Height of output image. Maximum size is 1024x768 or 768x1024 because of memory limits"}, "prompt"=>{"type"=>"string", "title"=>"Prompt", "default"=>"", "x-order"=>0, "description"=>"Input prompt"}, "init_image"=>{"type"=>"string", "title"=>"Init Image", "format"=>"uri", "x-order"=>3, "description"=>"Inital image to generate variations of. Will be resized to the specified width and height"}, "num_outputs"=>{"allOf"=>[{"$ref"=>"#/components/schemas/num_outputs"}], "default"=>1, "x-order"=>6, "description"=>"Number of images to output"}, "guidance_scale"=>{"type"=>"number", "title"=>"Guidance Scale", "default"=>7.5, "maximum"=>20, "minimum"=>1, "x-order"=>8, "description"=>"Scale for classifier-free guidance"}, "prompt_strength"=>{"type"=>"number", "title"=>"Prompt Strength", "default"=>0.8, "x-order"=>5, "description"=>"Prompt strength when using init image. 1.0 corresponds to full destruction of information in init image"}, "num_inference_steps"=>{"type"=>"integer", "title"=>"Num Inference Steps", "default"=>50, "maximum"=>500, "minimum"=>1, "x-order"=>7, "description"=>"Number of denoising steps"}}}, "width"=>{"enum"=>[128, 256, 512, 768, 1024], "type"=>"integer", "title"=>"width", "description"=>"An enumeration."}, "Output"=>{"type"=>"array", "items"=>{"type"=>"string", "format"=>"uri"}, "title"=>"Output"}, "Status"=>{"enum"=>["processing", "succeeded", "failed"], "type"=>"string", "title"=>"Status", "description"=>"An enumeration."}, "height"=>{"enum"=>[128, 256, 512, 768, 1024], "type"=>"integer", "title"=>"height", "description"=>"An enumeration."}, "Request"=>{"type"=>"object", "title"=>"Request", "properties"=>{"input"=>{"$ref"=>"#/components/schemas/Input"}, "output_file_prefix"=>{"type"=>"string", "title"=>"Output File Prefix"}}, "description"=>"The request body for a prediction"}, "Response"=>{"type"=>"object", "title"=>"Response", "required"=>["status"], "properties"=>{"error"=>{"type"=>"string", "title"=>"Error"}, "output"=>{"$ref"=>"#/components/schemas/Output"}, "status"=>{"$ref"=>"#/components/schemas/Status"}}, "description"=>"The response body for a prediction"}, "num_outputs"=>{"enum"=>[1, 4], "type"=>"integer", "title"=>"num_outputs", "description"=>"An enumeration."}, "ValidationError"=>{"type"=>"object", "title"=>"ValidationError", "required"=>["loc", "msg", "type"], "properties"=>{"loc"=>{"type"=>"array", "items"=>{"anyOf"=>[{"type"=>"string"}, {"type"=>"integer"}]}, "title"=>"Location"}, "msg"=>{"type"=>"string", "title"=>"Message"}, "type"=>{"type"=>"string", "title"=>"Error Type"}}}, "HTTPValidationError"=>{"type"=>"object", "title"=>"HTTPValidationError", "properties"=>{"detail"=>{"type"=>"array", "items"=>{"$ref"=>"#/components/schemas/ValidationError"}, "title"=>"Detail"}}}}}}}}.to_json
    stub_request(:get, "https://api.replicate.com/v1/models/stability-ai/stable-diffusion")
      .to_return(status: 200, body: response)

    client = Replicate::Client.new
    res = client.retrieve_model("stability-ai/stable-diffusion")
    assert_equal "stable-diffusion", res.name
  end
end
