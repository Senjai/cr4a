module MailForm
  class Base
    include ActiveModel::AttributeMethods
    include ActiveModel::Conversion
    include ActiveModel::Validations
    include MailForm::Validators

    extend ActiveModel::Naming
    extend ActiveModel::Translation
    extend ActiveModel::Callbacks

    define_model_callbacks :deliver

    attribute_method_prefix 'clear_'
    attribute_method_suffix '?'

    class_attribute :attribute_names
    self.attribute_names = []

    def initialize(attributes = {})
      attributes.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if attributes
    end

    def self.attributes(*names)
      attr_accessor(*names)
      define_attribute_methods(names)

      self.attribute_names += names
    end

    def persisted?
      false
    end

    def deliver
      if valid?
        run_callbacks(:deliver) do
          MailForm::Notifier.contact(self).deliver
        end
      else
        false
      end
    end

    protected

    def clear_attribute(attribute)
      send("#{attribute}=", nil)
    end

    def attribute?(attribute)
      send(attribute).present?
    end
  end
end
