# encoding: utf-8
# frozen_string_literal: true
# This file is distributed under New Relic's license terms.
# See https://github.com/newrelic/newrelic-ruby-agent/blob/main/LICENSE for complete details.

namespace :coverage do
  desc "Collates all result sets generated by the different test runners"
  task :report do
    require 'simplecov'
    require 'fileutils'

    SimpleCov.coverage_dir('coverage_results')

    if ENV['CI']
      SimpleCov.collate(Dir['*/coverage_*/.resultset.json']) do
        refuse_coverage_drop
      end
    else
      SimpleCov.collate(Dir['lib/coverage_*/.resultset.json'])
    end

    coverage_dirs = Dir['lib/coverage_*']
    coverage_dirs.delete('lib/coverage_results')
    coverage_dirs.each { |dir| FileUtils.rm_rf(dir) }
  end
end
