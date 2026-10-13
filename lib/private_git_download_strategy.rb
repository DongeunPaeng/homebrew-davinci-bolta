# typed: strict
# frozen_string_literal: true

require "download_strategy"

# Use the existing GitHub login only for authenticated source downloads.
class DavinciBoltaPrivateGitDownloadStrategy < GitHubGitDownloadStrategy
  def fetch(timeout: nil)
    @github_token = Utils.popen_read("gh", "auth", "token", "--hostname", "github.com", err: File::NULL).strip
    if !$CHILD_STATUS.success? || @github_token.empty?
      raise "GitHub login required: run gh auth login and gh auth setup-git"
    end

    super
  ensure
    @github_token = nil
  end

  private

  def env
    variables = super
    return variables unless fetching?
    return variables unless @github_token

    variables.merge("GH_TOKEN" => @github_token, "GH_HOST" => "github.com")
  end

  def command_output_options
    super.merge(secrets: Array(@github_token))
  end

  def silent_command(*args, **options)
    super(*args, **options.merge(secrets: Array(options[:secrets]) + Array(@github_token)))
  end
end
