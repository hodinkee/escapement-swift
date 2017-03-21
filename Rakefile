require "tmpdir"

def ensure_carthage
  raise "Carthage is not installed." unless system %Q[which carthage > /dev/null]
end

namespace :carthage do
  desc "Empty Carthage build folder."
  task :clean do
    system %Q[rm -rf "Carthage/Build"]
  end

  desc "Build Carthage dependencies."
  task :bootstrap do
    ensure_carthage
    system %Q[carthage bootstrap --platform ios,tvos]
  end
end

namespace :protobuf do
  input_path = "Carthage/Checkouts/hodinkee-protobuf/Definitions"
  output_path = "Escapement"
  swift_protobuf_path = "Carthage/Checkouts/swift-protobuf"

  desc "Clean swift-protobuf and all pb.swift files."
  task :clean do
    system %Q[rm -rf "#{output_path}"]
    system %Q[swift build --chdir "#{swift_protobuf_path}" --clean]
  end

  desc "Compile protobuf message defintions."
  task :compile do
    ensure_carthage

    system %Q[mkdir -p "#{input_path}"]
    system %Q[mkdir -p "#{output_path}"]

    system %Q[carthage checkout --no-use-binaries swift-protobuf]

    Dir.mktmpdir do |path|
      puts path
      system %Q[git clone https://github.com/hodinkee/hodinkee-protobuf "#{path}"]
      Dir.chdir path do
        system %Q[git checkout escapement]
      end
      system %Q[cp "#{File.join path, "Definitions/Escapement.proto"}" "#{input_path}"]
    end

    system %Q[swift build --chdir "#{swift_protobuf_path}"]

    system %Q[protoc \
      --plugin "#{swift_protobuf_path}/.build/debug/protoc-gen-swift" \
      --swift_out="#{output_path}" \
      --proto_path="#{input_path}" \
      "#{input_path}"/*.proto]
  end
end
