folder('tooling/python-sdk') {
    displayName('Python SDK')
    description('Contains jobs to run build, test, and publish the Agave Python SDK.')
}

job("tooling/python-sdk/python-sdk-docker-build") {
	description("This job runs the unit tests for the Agave python SDK. The tests are output in junit XML format and published with the Jenkins Xunit Plugin.")
	keepDependencies(false)
	disabled(false)
	concurrentBuild(true)
	scm {
		git {
			remote {
				github("git@github.com:agaveplatform/python-sdk.git", "ssh")
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
          docker-compose -f docker-compose.test.yml build tox
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

job("tooling/python-sdk/python-sdk-tests") {
	description("This job runs the unit tests for the Agave python SDK. The tests are output in TAP format and published with the Jenkins TAP Plugin.")
	keepDependencies(false)
	disabled(false)
	concurrentBuild(true)
	scm {
		git {
			remote {
				github("git@github.com:agaveplatform/python-sdk.git", "ssh")
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
	        # copy credentials into the source directory that we will be copying into position
          ln -s $TEST_CREDENTIALS agavepy/tests/test_credentials.json
          ln -s $ADMIN_CREDENTIALS agavepy/tests/test_credentials_admin_tests.json
          ln -s $LARGE_FILE agavepy/tests/test_largefile_upload_python_sdk
      '''.stripIndent().trim()

    virtualenv {
        name('venv')
        command('pip install -r requirements.txt')
        command('cd agavepy/test && py.test --junitxml=reports/junit-report.xml')
        clear()
    }

    shell '''
          unlink agavepy/tests/test_credentials.json
          unlink agavepy/tests/test_credentials_admin_tests.json
          unlink agavepy/tests/test_largefile_upload_python_sdk
      '''.stripIndent().trim()

//    shell '''
//          cat EOF
//          FROM python:3
//
//          WORKDIR /usr/src/app
//
//          COPY requirements.txt ./
//          RUN pip install --no-cache-dir -r requirements.txt
//
//          COPY . .
//
//          WORKDIR /usr/src/app/agavepy/test
//
//          CMD [ "py.test", "--junitxml=reports/junit-report.xml" ]
//
//          EOF > Dockerfile.pytest
//
//      '''.stripIndent().trim()
//
//	  shell '''
//          #export AGAVE_USERNAME=testuser
//          #export AGAVE_PASSWORD=testuser
//          #export AGAVE_TENANT=sandbox
//          #export AGAVE_TENANTS_API_BASEURL=https://sandbox.agaveplatform.org/tenants
//          #export AGAVE_CACHE_DIR=$HOME/.agavepytest
//
//          # ensure test directory is present
//          mkdir -p reports
//
//		      # add the test-credentials file and virtualenvs
//          docker run --rm \
//              -v $(pwd):/agavepy
//              -w /agavepy/agavepy/test
//              agaveapi/agavepy_testrunner \
//                pip install -r requirements.txt && cd /agavepy/agavepy/test && py.test --junitxml=reports/junit-report.xml
//      '''.stripIndent().trim()
//
//    shell '''
//          rm -f agavepy/tests/test_credentials.json
//          rm -f agavepy/tests/test_credentials_admin_tests.json
//          rm -f agavepy/tests/test_largefile_upload_python_sdk
//
//
//		  '''.stripIndent().trim()

	}
	publishers {
		archiveJunit("agavepy/test/reports/*.xml") {
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
