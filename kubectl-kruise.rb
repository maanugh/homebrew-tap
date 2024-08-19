class KubectlKruise < Formula
    desc "Automated management of large-scale applications on Kubernetes (incubating project under CNCF)"
    homepage "https://openkruise.io/"
    url "https://github.com/openkruise/kruise-tools/archive/refs/tags/v1.1.2.tar.gz"
    sha256 "ca9b842563b60668791cbe5e68dfc2826a38c8201b452cbc6c531b422f844c62"
    license "Apache-2.0"
    head "https://github.com/openkruise/kruise-tools.git", branch: "master"
  
    depends_on "go" => :build
  
    def install
        ENV["CGO_ENABLED"] = "0"
        ENV["GO111MODULE"] = "on"
        ldflags = Utils.safe_popen_read("#{buildpath}/version.sh").chomp

        system "go", "build", "-ldflags", ldflags, "./cmd/plugin/main.go"
  
    end
  
    test do
  
      assert_match version.to_s, shell_output("#{bin}/kubectl-kruise version")
    end
  end