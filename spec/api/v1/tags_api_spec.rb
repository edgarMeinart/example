# frozen_string_literal: true

RSpec.describe V1::ProductsApi, type: :request do
  let(:headers) do
    {
      "Accept" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
  end

  describe "GET /api/v1/tags/" do
    subject(:make_request) do
      get("/api/v1/tags", headers: headers)
      response
    end

    context "when products missing" do
      it "responds with empty result" do
        is_expected.to(
          match_response_schema("json_api.empty").and(have_http_status(200))
        )
      end
    end
  end

  describe "GET v1/tags/:id" do
    subject(:make_request) do
      get("/api/v1/tags/#{ tag.id }", headers: headers)
      response
    end

    let(:tag) { create(:tag) }

    context "when tag missing" do
      let(:tag) { build_stubbed(:tag) }

      it "responds with 200 and error" do
        is_expected.to(
          match_response_schema("json_api.errors").and(have_http_status(404))
        )
      end
    end

    it "responds with HTTP 200 and given tag" do
      is_expected.to(
        match_response_schema("json_api.tag").and(have_http_status(200))
      )
    end
  end

  describe "POST /api/v1/tags/" do
    subject(:make_request) do
      post("/api/v1/tags/", params: params.to_json, headers: headers)
      response
    end

    let(:params) do
      {
        data: {
          id: "undefined",
          type: "undefined",
          attributes: {
            title: tag_name,
          }
        }
      }
    end
    let(:tag_name) { "Coca" }

    context "when passed invalid attribute" do
      let(:tag_name) { "" }

      it "responds with HTTP 200 and error" do
        is_expected.to(
          match_response_schema("json_api.errors").and(have_http_status(400))
        )
      end
    end

    it "responds with HTTP 201 and given tag" do
      is_expected.to(
        match_response_schema("json_api.tag").and(have_http_status(201))
      )
    end
  end

  describe "PATCH v1/tags/:id" do
    subject(:make_request) do
      patch("/api/v1/tags/#{ tag.id }", params: params.to_json, headers: headers)
      response
    end

    let(:tag) { create(:tag) }
    let(:params) do
      {
        data: {
          id: tag.id,
          type: "tags",
          attributes: {
            title: "Drinks"
          }
        }
      }
    end

    it "updates given tag" do
      expect_call.to(
        change { tag.reload.title }.to("Drinks")
      )
    end

    it "responds with HTTP 200 and given tag" do
      is_expected.to(
        match_response_schema("json_api.tag").and(have_http_status(200))
      )
    end
  end

  describe "DELETE v1/q/:id" do
    subject(:make_request) do
      delete("/api/v1/tags/#{ tag.id }", headers: headers)
      response
    end

    let(:tag) { create(:tag) }

    it "removes passed tag" do
      tag

      expect_call.to(
        change{ Tag.count }
      )
    end

    it "responds with tag" do
      is_expected.to(
        match_response_schema("json_api.tag").and(have_http_status(200))
      )
    end
  end
end
