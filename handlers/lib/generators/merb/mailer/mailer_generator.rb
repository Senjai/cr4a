require 'rails/generators/erb/mailer/mailer_generator'

module Merb
  module Generators
    class MailerGenerator < Erb::Generators::MailerGenerator
      source_root File.expand_path("../templates", __FILE__)

      protected

      def format
        nil
      end

      def handler
        :merb
      end
    end
  end
end
