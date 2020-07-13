# frozen_string_literal: true

RSpec.shared_context("with_expect_call", with_expect_call: true) do
  let(:expect_call) { expect{ subject } }
end
