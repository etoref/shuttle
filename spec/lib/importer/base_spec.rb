# encoding: utf-8

# Copyright 2014 Square Inc.
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

require 'spec_helper'

describe Importer::Base do
  describe "#base_rfc5646_locale" do
    it "returns blob's project's base rfc5646 locale" do
      project = FactoryGirl.create(:project, base_rfc5646_locale: 'en-TR')
      blob = FactoryGirl.create(:fake_blob, project: project)
      expect(Importer::Android.new(blob).base_rfc5646_locale).to eql('en-TR')
    end
  end
end