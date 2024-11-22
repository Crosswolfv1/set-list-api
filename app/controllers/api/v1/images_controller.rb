class Api::V1::ImagesController < ApplicationController
  def show
    artist = params["artist"]
    conn = Faraday.new(url: "https://api.unsplash.com/") do |faraday|
      faraday.params["client_id"] = Rails.application.credentials.unsplash[:key]
    end

    response = conn.get("/search/photos", { query: artist })
    json = JSON.parse(response.body, symbolize_names: true)

    first_photo = json[:results][0]

    formatted_json = {
      id: nil,
      type: "image",
      attributes: {
        image_url: first_photo[:urls][:regular],
        photographer: first_photo[:user][:name],
        photographer_url: first_photo[:user][:links][:html],
        alt_text: first_photo[:alt_description]
      }
    }

    render json: { data: formatted_json }
  end
end