# frozen_string_literal: true

MoneyRails.configure do |config|
  config.default_currency = :eur
  config.amount_column = {
    postfix: "_amount"
  }
  config.rounding_mode = BigDecimal::ROUND_HALF_UP
end
