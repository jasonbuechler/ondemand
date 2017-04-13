require 'test_helper'

class JobstatussataTest < ActiveModel::TestCase


  @clusters = OODClusters
  @test_count = 0

  @clusters.each do |cluster|

    jobs = cluster.job_adapter.info_all



    jobs.each do |job|
      data = Jobstatusdata.new(job, cluster, true)

      test "test job id #{@test_count}" do
        assert data.pbsid.is_a?(String), data.pbsid

        assert data.pbsid.length > 0
      end

      test "test jobname #{@test_count}" do
        assert data.jobname.is_a?(String), data.jobname
      end

      test "test username #{@test_count}" do
        assert data.username.is_a?(String), data.username

        assert data.pbsid.length > 0
      end

      test "test account #{@test_count}" do
        assert data.account.is_a?(String), data.account
      end

      test "test status #{@test_count}" do
        assert_not_nil data.status

        assert data.status.is_a?(String), data.status.class.name
      end

      test "test cluster #{@test_count}" do
        assert data.cluster.instance_of?(OodCore::Cluster), data.cluster
      end

      test "test nodes #{@test_count}" do
        if job.status.state == :running || job.status.state == :completed
          assert data.nodes.respond_to?('each'), data.nodes.inspect
        else
          assert data.nodes.nil?, "Not nil #{data.nodes.inspect}"
        end
      end

      test "test starttime #{@test_count}" do
        if job.status.state == :running || job.status.state == :completed
          assert data.starttime.is_a?(Integer), data.starttime.inspect

          assert data.starttime >= 0
        else
          assert data.starttime.nil?, "Not nil #{data.starttime}"
        end
      end

      test "test submit_args #{@test_count}" do
        assert data.submit_args.is_a?(String), data.submit_args
      end

      test "test output_path #{@test_count}" do
        assert data.output_path.is_a?(String), data.output_path
      end

      test "test extended_available #{@test_count}" do
        assert data.extended_available.in?( [true, false] ), data.extended_available
      end

      test "test terminal_path #{@test_count}" do
        assert data.terminal_path.is_a?(String), "Was #{data.terminal_path.class.name} expecting String"
      end

      test "test fs_path #{@test_count}" do
        assert data.fs_path.is_a?(String), "Was #{data.fs_path.class.name} expecting String"
      end

      @test_count += 1
    end


  end

end


