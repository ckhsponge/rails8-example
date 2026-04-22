class Link < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }

  after_create_commit  -> { broadcast_prepend_to "links", partial: "links/link", locals: { link: self }, target: "links" }
  after_update_commit  -> { broadcast_replace_to "links", partial: "links/link", locals: { link: self }, target: "link_#{id}" }
  after_destroy_commit -> { broadcast_remove_to "links", target: "link_#{id}" }
end
