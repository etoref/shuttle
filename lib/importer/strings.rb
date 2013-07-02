# Copyright 2013 Square Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

require 'strscan'

module Importer

  # Parses translatable strings from Cocoa/Objective-C .strings files.

  class Strings < Base
    include ::CStrings

    def self.fencers() %w(Printf) end

    protected

    def import_file?(locale=nil)
      file.path =~ /#{Regexp.escape(locale_to_use(locale).rfc5646)}\.lproj\/[^\/]+\.strings$/
    end

    def self.encoding() %w(UTF-8 UTF-16BE UTF-16LE) end

    def import_strings(receiver)
      file.contents.scan(/(?:\/*\*\s*(.+?)\s*\*\/)?\s*"(.+?)"\s*=\s*"(.+?)";/um).each do |(context, key, value)|
        receiver.add_string "#{file.path}:#{unescape(key)}", unescape(value),
                            context:      context,
                            original_key: unescape(key)
      end
    end
  end
end
