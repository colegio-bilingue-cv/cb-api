desc 'Generate default paymentMethodsOptions instances'
task generate_payment_methods: :environment do
  PaymentMethod.create!(method: 'Efectivo')
  PaymentMethod.create!(method: 'Financiación')
  PaymentMethod.create!(method: 'Licitación')
end
