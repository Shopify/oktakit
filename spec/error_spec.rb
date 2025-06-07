require "spec_helper"

describe Oktakit::Error do
  describe "#from_response(response)" do
    context "success" do
      subject(:from_response) { described_class.from_response(okta_response, 404) }

      context "with response and status" do
        let(:okta_response) do
          {
            errorCode: "00000000",
            errorSummary: "Not found: Resource not found: example@example.com (User)",
            errorLink: "E0000007",
            errorId: "00000000",
            errorCauses: [],
          }
        end

        it "returns an instance of the described class" do
          expect(from_response.class).to(eq(Oktakit::NotFound))
        end

        it "returns a meaningful error message" do
          expected_message = "404 - Not found: Resource not found: example@example.com (User)"

          expect(from_response.message).to(eq(expected_message))
        end
      end

      context "with missing response" do
        let(:okta_response) { {} }

        it "returns an instance of the described class" do
          expect(from_response.class).to(eq(Oktakit::NotFound))
        end

        it "returns a meaningful error message" do
          expect(from_response.message).to(eq("404"))
        end
      end

      context "with a different response format" do
        let(:okta_response) do
          {
            status: 404,
            method: "POST",
            url: "http://example.com/api/v1",
            response_headers: {
              content_type: "json",
            },
            body: {
              errorCode: "E0000007",
              errorSummary: "Not found: Resource not found: abrakadabrasdfskdkf@admin.com (User)",
              errorLink: "E0000007",
              errorId: "oaeLRic8zbhTBiJ81eJnWTQUg",
              errorCauses: [],
            },
          }
        end

        it "returns an instance of the described class" do
          expect(from_response.class).to(eq(Oktakit::NotFound))
        end

        it "returns a meaningful error message" do
          expected_message = "POST http://example.com/api/v1 : 404"

          expect(from_response.message).to(eq(expected_message))
        end
      end
    end

    context "with errors" do
      context "with missing status" do
        subject(:from_response) { described_class.from_response(okta_response, 0) }

        let(:okta_response) do
          {
            errorCode: "00000000",
            errorSummary: "Not found: Resource not found: example@example.com (User)",
            errorLink: "E0000007",
            errorId: "00000000",
            errorCauses: [],
          }
        end

        it { is_expected.to(be_nil) }
      end
    end
  end
end
