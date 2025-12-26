class AwsSsoRefresh < Formula
  desc "Automatically refresh AWS SSO sessions before they expire"
  homepage "https://github.com/jhubbardsf/aws-sso-refresh"
  url "https://github.com/jhubbardsf/aws-sso-refresh/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "d953a67c3f90a38614499464d6e79228499b44b3247dc7d0ef92bbed08db3e82"
  license "MIT"
  head "https://github.com/jhubbardsf/aws-sso-refresh.git", branch: "main"

  depends_on "bash" => "4.0"
  depends_on "jq"
  depends_on "awscli"

  def install
    bin.install "bin/aws-sso-refresh"
  end

  def caveats
    <<~EOS
      To enable automatic background refresh:
        aws-sso-refresh install

      To check your SSO session status:
        aws-sso-refresh status

      The daemon will run every 10 minutes (configurable) and refresh
      sessions that are within 30 minutes of expiring (configurable).

      Configure check interval and threshold with:
        export AWS_SSO_REFRESH_INTERVAL=5   # Check every 5 minutes (default: 10)
        export AWS_SSO_REFRESH_THRESHOLD=5  # Refresh 5m before expiry (default: 30)
    EOS
  end

  test do
    assert_match "aws-sso-refresh v", shell_output("#{bin}/aws-sso-refresh version")
  end
end
