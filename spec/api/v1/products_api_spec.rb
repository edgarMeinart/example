# frozen_string_literal: true

RSpec.describe V1::ProductsApi, type: :request do
  let(:headers) do
    {
      "Accept" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
  end

  describe "GET /api/v1/products/" do
    subject(:make_request) do
      get("/api/v1/products", headers: headers)
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

  describe "GET v1/products/:id" do
    subject(:make_request) do
      get("/api/v1/products/#{ product.id }", headers: headers)
      response
    end

    let(:product) { create(:product) }

    context "when product missing" do
      let(:product) { build_stubbed(:product) }

      it "responds with 200 and error" do
        is_expected.to(
          match_response_schema("json_api.errors").and(have_http_status(404))
        )
      end
    end

    it "responds with HTTP 200 and given product" do
      is_expected.to(
        match_response_schema("json_api.product").and(have_http_status(200))
      )
    end
  end

  describe "POST /api/v1/products/" do
    subject(:make_request) do
      post("/api/v1/products/", params: params.to_json, headers: headers)
      response
    end

    let(:params) do
      {
        data: {
          id: "undefined",
          type: "undefined",
          attributes: {
            name: product_name,
            description: "of Bottle",
            price: "1.98"
          }
        }
      }
    end
    let(:product_name) { "Coca" }

    context "when passed invalid attribute" do
      let(:product_name) { "" }

      it "responds with HTTP 200 and error" do
        is_expected.to(
          match_response_schema("json_api.errors").and(have_http_status(400))
        )
      end
    end

    it "responds with HTTP 201 and given product" do
      is_expected.to(
        match_response_schema("json_api.product").and(have_http_status(201))
      )
    end
  end

  describe "PATCH v1/products/:id" do
    subject(:make_request) do
      patch("/api/v1/products/#{ product.id }", params: params.to_json, headers: headers)
      response
    end

    let(:product) { create(:product) }
    let(:params) do
      {
        data: {
          id: product.id,
          type: "products",
          attributes: {
            name: "Pepsi"
          }
        }
      }
    end

    it "updates given product" do
      expect_call.to(
        change { product.reload.name }.to("Pepsi")
      )
    end

    it "responds with HTTP 200 and given product" do
      is_expected.to(
        match_response_schema("json_api.product").and(have_http_status(200))
      )
    end
  end

  describe "DELETE v1/q/:id" do
    subject(:make_request) do
      delete("/api/v1/products/#{ product.id }", headers: headers)
      response
    end

    let(:product) { create(:product) }

    it "removes passed product" do
      product

      expect_call.to(
        change{ Product.count }
      )
    end

    it "responds with product" do
      is_expected.to(
        match_response_schema("json_api.product").and(have_http_status(200))
      )
    end
  end
end
