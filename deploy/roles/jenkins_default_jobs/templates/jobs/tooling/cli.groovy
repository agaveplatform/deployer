folder('tooling/cli') {
    displayName('Tooling')
    description('Contains jobs to run unit tests for the official Agave Platform tooling: cli, sdk, etc.')
}

job("tooling/cli/cli-unit-tests") {
	description("This job runs the bats test suites for the Agave CLI. The tests are output in TAP format and published with the Jenkins TAP Plugin.")
	keepDependencies(false)
	disabled(false)
	concurrentBuild(true)
	scm {
		git {
			remote {
				github("git@github.com:agaveplatform/agave-cli.git", "ssh")
			}
			branch("*/develop")
		}
	}
	triggers {
		scm("H/5 * * * *") {
			ignorePostCommitHooks(false)
		}
	}
	steps {
		shell '''
          export AGAVE_USERNAME=testuser
          export AGAVE_PASSWORD=testuser
          export AGAVE_TENANT=sandbox
          export AGAVE_TENANTS_API_BASEURL=https://sandbox.agaveplatform.org/tenants

		      mkdir -p reports
		      bats --tap test/bin > reports/tap-report.tap
      '''.stripIndent().trim()
	}
	publishers {
		archiveJunit("reports/*.tap") {
			healthScaleFactor(1.0)
			allowEmptyResults(false)
		}
	}
	configure {
		it / 'properties' / 'jenkins.model.BuildDiscarderProperty' {
			strategy {
				'daysToKeep'('1')
				'numToKeep'('5')
				'artifactDaysToKeep'('-1')
				'artifactNumToKeep'('-1')
			}
		}
	}
}

job("tooling/cli/cli-docker-build") {
	description("This job runs the bats test suites for the Agave CLI. The tests are output in TAP format and published with the Jenkins TAP Plugin.")
	keepDependencies(false)
	disabled(false)
	concurrentBuild(true)
	steps {
		shell '''
          docker build --rm -t agaveplatform/agave-cli:develop .
      '''.stripIndent().trim()
	}
	configure {
		it / 'properties' / 'jenkins.model.BuildDiscarderProperty' {
			strategy {
				'daysToKeep'('1')
				'numToKeep'('5')
				'artifactDaysToKeep'('-1')
				'artifactNumToKeep'('-1')
			}
		}
	}
}