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
require 'build/dependency/base'
require 'build/maven'

module Build
  module Dependency
    class PostgreSQLJDBC < Base
      include Build::Maven

      def initialize(options)
        super 'postgresql-jdbc', 'jar', options
      end

      protected

      def normalize(raw)
        raw.sub(/-/, '.').sub(/-/, '_')
      end

      def version_specific(version)
        if version =~ /^[\d\.-]+$/ && version > '9.2'
          ->(v) { release MAVEN_CENTRAL, 'org.postgresql', 'postgresql', "#{v}-jdbc4" }
        elsif version =~ /^8/ || version =~ /^9.0/ || version =~ /^9.1/
          ->(v) { release MAVEN_CENTRAL, 'postgresql', 'postgresql', "#{v}.jdbc4" }
        else
          fail "Unable to process version '#{version}'"
        end
      end
    end
  end
end
