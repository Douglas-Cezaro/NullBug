class AccountSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :birth_date, :document_url

  def document_url
    if object.document.present?
      Rails.application.routes.url_helpers.rails_blob_url(object.document, only_path: false)
    end
  end
end
