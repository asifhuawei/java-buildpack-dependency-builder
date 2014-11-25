# Encoding: utf-8
# Copyright (c) 2013 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'build/dependency'
require 'build/dependency/openjdk/openjdk_resources'
require 'build/dependency/util/platform_details'
require 'fileutils'

module Build
  module Dependency
    class BootstrapJDK6Builder
      include OpenJDKResources
      include PlatformDetails

      def build
        return if File.exist?(root)

        puts 'Downloading bootstrap JDK...'
        FileUtils.mkdir_p root
        system "curl -ssL http://boxes.gopivotal.com.s3.amazonaws.com/#{codename}64-openjdk-1.6.0_31.tar.gz | tar xz --strip 1 -C #{root}"
      end

      def root
        File.join VENDOR_DIR, 'bootstrap-jdk-6', codename
      end
    end
  end
end
