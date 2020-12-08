require 'spec_helper'

describe Oktakit::Client::Templates do
  TEMPLATES_TEMPLATE_ID = 'cst6o2l24rIv1tC840h7'

  describe '#add_sms_template' do
    it 'returns the created sms template.' do
      VCR.use_cassette('add_sms_template') do
        resp, = client.add_sms_template(
          name: "Custom",
          type: "SMS_VERIFY_CODE",
          template: "${org.name}: your verification code is ${code}",
          translations:
          {
            es: "${org.name}: el código de verificación es ${code}",
            fr: "${org.name}: votre code de vérification est ${code}",
            it: "${org.name}: il codice di verifica è ${code}",
          }
        )
        expect(resp.id).not_to(be_nil)
      end
    end
  end

  describe '#get_sms_template' do
    it 'returns fetched sms template' do
      VCR.use_cassette('get_sms_template') do
        resp, = client.get_sms_template(TEMPLATES_TEMPLATE_ID)
        expect(resp.id).to(be == TEMPLATES_TEMPLATE_ID)
      end
    end
  end

  describe '#list_sms_templates' do
    it 'returns array of sms template' do
      VCR.use_cassette('list_sms_templates') do
        resp, = client.list_sms_templates
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#update_sms_template' do
    it 'returns updated sms template' do
      VCR.use_cassette('update_sms_template') do
        _, status = client.update_sms_template(TEMPLATES_TEMPLATE_ID,
                                               name: "Custom",
                                               type: "SMS_VERIFY_CODE",
                                               template: "Your ${org.name} code is: ${code}",
                                               translations:
                                               {
                                                 es: "${org.name}: ${code}.",
                                                 fr: "${org.name}: ${code}.",
                                                 it: "${org.name}: ${code}.",
                                               })
        expect(status).to(be(200))
      end
    end
  end

  describe '#partial_sms_template_update' do
    it 'returns updated sms template' do
      VCR.use_cassette('partial_sms_template_update') do
        resp, = client.partial_sms_template_update(TEMPLATES_TEMPLATE_ID,
                                                   translations: {
                                                     de: "${org.name}: ihre bestätigungscode ist ${code}.",
                                                   })
        expect(resp.translations.de).to(be == '${org.name}: ihre bestätigungscode ist ${code}.')
      end
    end
  end

  describe '#remove_sms_template' do
    it 'returns there is no content in the response.' do
      VCR.use_cassette('remove_sms_template') do
        _, status = client.remove_sms_template(TEMPLATES_TEMPLATE_ID)
        expect(status).to(be(204))
      end
    end
  end
end
